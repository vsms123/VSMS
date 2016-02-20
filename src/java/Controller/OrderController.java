/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.IngredientDAO;
import DAO.OrderDAO;
import DAO.UserDAO;
import Model.Dish;
import Model.Ingredient;
import Model.Order;
import Model.Orderline;
import Model.Supplier;
import Model.Vendor;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.TreeMap;
import javamail.EmailController;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/orderservlet/*")
public class OrderController extends HttpServlet {

    @Override
    //doPost will be given to Order.jsp and OrderBreakdown.jsp
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //An order order_id, vendor_id, total_final_price, dt_order;

        //A dish will have int dish_id; String dish_name; int vendor_id;String dish_description;HashMap<Ingredient, ArrayList<String>> ingredientQuantity;
        //An ingredient will have  int supplier_id; String name;private String supplyUnit;private String subcategory;private String description;private String offeredPrice;
        //A OrderLine will have int vendor_id;int order_id;int supplier_id;String ingredient_name;double finalprice;int quantity;double bufferpercentage;
        //An  order int order_id,int vendor_id; double total_final_price;Date dt_order;ArrayList<Orderline> orderlines;
        ArrayList<Dish> dishList = IngredientDAO.getDish("1");
        String vendor_idStr = request.getParameter("vendor_id");
        String action = request.getParameter("action");
        String bufferqtypercStr = request.getParameter("bufferqtyperc");

        String htmlConfirmation = "";
        //supplier id and order id is auto generated
        //final price is aggregated, ingredient name is there
        //check if the form is submitted or not, if the form is submitted then the dish_countStr should not be null
        if (!UtilityController.checkNullStringArray(new String[]{vendor_idStr})) {
            if (action.equals("confirm")) { //This is to display the modal and the state of the orders to be modified
                //Create a hashmap with <Dishid, quantity input)
                HashMap<Integer, Integer> dishQuantityMap = createDishQuantityMap(dishList, request);
                int vendor_id = UtilityController.convertStringtoInt(vendor_idStr);
                //Create an hashmap with <Ingredient, aggregated quantity> (TESTED)
                HashMap<Ingredient, Integer> ingredientAggQuantityMap = createIngredientAggQuantityMap(dishQuantityMap);
                ArrayList<Orderline> orderlineList = new ArrayList<Orderline>();
                if (bufferqtypercStr != null) {//This means it comes from order breakdown
                    int bufferqtyperc = UtilityController.convertStringtoInt(bufferqtypercStr);
                    //Make an arraylist of all orderline (non aggregated) with buffer quantity
                    orderlineList = createOrderlineList(ingredientAggQuantityMap, vendor_id, getLatestOrderID() + 1, bufferqtyperc);
                } else {
                    //Make an arraylist of all orderline (non aggregated)
                    orderlineList = createOrderlineList(ingredientAggQuantityMap, vendor_id, getLatestOrderID() + 1);
                }
                //Create a hashmap of orderlines based on suppliers
                HashMap<Supplier, ArrayList<Orderline>> supplierOrderlineMap = createSupplierOrderlineMap(orderlineList);
                //Create a hashmap of Order based on suppliers
                HashMap<Supplier, Order> supplierOrderMap = createSupplierOrderMap(supplierOrderlineMap, getLatestOrderID() + 1, vendor_id);
                //Change this into an html to be shown at the modal
                htmlConfirmation = retrieveConfirmationHTML(supplierOrderMap);
            } else {//create
                HashMap<Integer, Integer> dishQuantityMap = createDishQuantityMap(dishList, request);
                int vendor_id = UtilityController.convertStringtoInt(vendor_idStr);
                //Create an hashmap with <Ingredient, aggregated quantity> (TESTED)
                HashMap<Ingredient, Integer> ingredientAggQuantityMap = createIngredientAggQuantityMap(dishQuantityMap);
                //Make an arraylist of all orderline (non aggregated)
                ArrayList<Orderline> orderlineList = createOrderlineList(ingredientAggQuantityMap, vendor_id, getLatestOrderID() + 1);
                //Create a hashmap of orderlines based on suppliers
                HashMap<Supplier, ArrayList<Orderline>> supplierOrderlineMap = createSupplierOrderlineMap(orderlineList);
                //Create a hashmap of Order based on suppliers
                HashMap<Supplier, Order> supplierOrderMap = createSupplierOrderMap(supplierOrderlineMap, getLatestOrderID() + 1, vendor_id);
                //iterate the output
                Iterator iter = supplierOrderMap.keySet().iterator();
                while (iter.hasNext()) {
                    Supplier supplier = (Supplier) iter.next();
                    Order order = supplierOrderMap.get(supplier);
                    //Do 2 things: 1. Insert these orders inside the database 2. send these orders to the suppliers and vendors with email
                    addOrder(order);

                    //MailController Method
//              Will send the email to all the suppliers and the vendor
                    EmailController.sendOrderMessageToVendorSupplier(order, vendor_id);
                }
                response.sendRedirect("Order.jsp");
            }

        }

        response.setContentType("text/plain");  // Set content type of the response so that AJAX knows what it can expect.
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(htmlConfirmation);       // Write response body.
    }

    @Override
    //doPost will be given to OrderConfirmation.jsp
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Will get order_id and action (approve/reject)
        String order_idStr = request.getParameter("order_id");
        String action = request.getParameter("action");

        //check if the form is submitted or not, if the form is submitted then the dish_countStr should not be null
        if (!UtilityController.checkNullStringArray(new String[]{order_idStr, action})) {
            int order_id = UtilityController.convertStringtoInt(order_idStr);
            Order order = retrieveOrderByID(order_id);
            //Do 3 things: 1. Update this orders inside the database 2. send these update orders to the suppliers and vendors with email 3. Redirect suppliers to a thank you page
            if (action.equals("approve")) {
                updateOrder(new Order(order_id, order.getVendor_id(), order.getTotal_final_price(), order.getDtOrder(), "approved", order.getOrderlines()));
            } else if (action.equals("reject")) {
                updateOrder(new Order(order_id, order.getVendor_id(), order.getTotal_final_price(), order.getDtOrder(), "rejected", order.getOrderlines()));
            }

            //MailController Method
            //Will send the email to all the suppliers and the vendor
            EmailController.sendConfirmationMessageToVendorSupplier(order, order.getVendor_id(), action);

            response.sendRedirect("SupplierConfirmationThankYou.jsp");
        }

        response.setContentType("text/plain");  // Set content type of the response so that AJAX knows what it can expect.
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Unsuccessful");       // Write response body.
    }

    public String retrieveConfirmationHTML(HashMap<Supplier, Order> supplierOrderMap) {
        StringBuffer htmlTable = new StringBuffer("");
        Iterator iter = supplierOrderMap.keySet().iterator();
        double totalFinalPrice = 0;
        int count = 1;
        while (iter.hasNext()) {
            Supplier supplier = (Supplier) iter.next();
            Order order = supplierOrderMap.get(supplier);

            double subtotal = 0;
            for (Orderline orderline : order.getOrderlines()) {
                subtotal += orderline.getFinalprice();
            }

            if (subtotal > 0.0) {
                DecimalFormat df = new DecimalFormat("#.##");
                //Create sub categories sections
                htmlTable.append("<h3>Supplier #" + count + " " + supplier.getSupplier_name() + "</h3>");
                count++;
                htmlTable.append("<div class='ui six wide'>");
                htmlTable.append("<table class='ui celled table six wide'>");
                htmlTable.append("<thead><tr>");
                htmlTable.append("<th>Ingredient</th>");
                htmlTable.append("<th>Quantity</th>");
                htmlTable.append("<th>Unit</th>");
                htmlTable.append("<th>Subtotal</th>");
                htmlTable.append("</tr></thead>");
                htmlTable.append("<tbody>");
                for (Orderline orderline : order.getOrderlines()) {
                    if (orderline.getFinalprice() > 0.0) {
                        htmlTable.append("<tr>");
                        htmlTable.append("<td class='eight wide'>" + orderline.getIngredient_name() + "</td>");
                        htmlTable.append("<td class='two wide'>" + orderline.getQuantity() + "</td>");
                        htmlTable.append("<td class='two wide'>" + IngredientController.getIngredient(Integer.toString(orderline.getSupplier_id()), orderline.getIngredient_name()).getSupplyUnit() + "</td>");
                        htmlTable.append("<td class='two wide'>" + UtilityController.convertDoubleToCurrString(orderline.getFinalprice()) + "</td>");
                        htmlTable.append("</tr>");
                        totalFinalPrice += orderline.getFinalprice();
                    }
                }
                htmlTable.append("</tbody>");
                htmlTable.append("</table>");
                htmlTable.append("</div>");
                htmlTable.append("<h2><font color='red'>Total order: " + UtilityController.convertDoubleToCurrString(order.getTotal_final_price()) + "</font></h2><hr/>");
            }
        }
        htmlTable.append("<h1><font color='red'>Total final price: " + UtilityController.convertDoubleToCurrString(totalFinalPrice) + "</font></h1>");
        return htmlTable.toString();
    }
//    Test controller
//    public static void main(String[] args) {
//        ArrayList<Order> orderList = OrderDAO.retrieveAllOrderList();
//        for (Order order: orderList){
//            System.out.println(order);
//        }
//    }

    public static HashMap<Integer, Integer> createDishQuantityMap(ArrayList<Dish> dishList, HttpServletRequest request) {
//            Prepare array to store the map of dish id and the quantity put
        HashMap<Integer, Integer> dishQuantityMap = new HashMap<Integer, Integer>();

//            This will iterate through the list of the dishes and names
        for (Dish dish : dishList) {
            //Read the parameter quantity for this particular dish
            String quantityStr = request.getParameter("dish" + dish.getDish_id());
            int quantity = UtilityController.convertStringtoInt(quantityStr);
            //put this inside the hashmap
            dishQuantityMap.put(dish.getDish_id(), quantity);
        }
        //for debugging purpose
        System.out.println(dishQuantityMap.toString());
        return dishQuantityMap;
    }

    public HashMap<Ingredient, Integer> createIngredientAggQuantityMap(HashMap<Integer, Integer> dishQuantityMap) {
        HashMap<Ingredient, Integer> ingredientAggQuantityMap = new HashMap<Ingredient, Integer>();

        //iterate through dishQuantityMap
        Iterator iter = dishQuantityMap.keySet().iterator();
        while (iter.hasNext()) {
            int dish_id = (int) iter.next();
            int quantityOrder = dishQuantityMap.get(dish_id);

            Dish dish = IngredientDAO.getDishByID(dish_id);
            //Open the dish to ingredients and accumulate their quantity
            HashMap<Ingredient, ArrayList<String>> ingredientQuantity = dish.getIngredientQuantity();
            Iterator iterIngQuantity = ingredientQuantity.keySet().iterator();
            while (iterIngQuantity.hasNext()) {
                Ingredient ingredient = (Ingredient) iterIngQuantity.next();
                ArrayList<String> quantityUnitStr = ingredientQuantity.get(ingredient);
                String quantityStr = quantityUnitStr.get(0);
                String unit = quantityUnitStr.get(1);

                //aggregate the quantity
                int quantityAgg = quantityOrder * UtilityController.convertStringtoInt(quantityStr);

                if (!ingredientAggQuantityMap.containsKey(ingredient)) {
                    //insert ingredient and aggregated quantity to map
                    ingredientAggQuantityMap.put(ingredient, quantityAgg);
                } else {
                    //poll ingredient and aggregated quantity to map
                    ingredientAggQuantityMap.put(ingredient, ingredientAggQuantityMap.get(ingredient) + quantityAgg);
                }
            }
        }
        //for debugging purpose
        System.out.println(dishQuantityMap.toString());
        return ingredientAggQuantityMap;
    }

    public ArrayList<Orderline> createOrderlineList(HashMap<Ingredient, Integer> ingredientAggQuantityMap, int vendor_id, int order_id) {
        ArrayList<Orderline> orderlineList = new ArrayList<Orderline>();

        //iterate through ingredientAggQuantityMap
        Iterator iter = ingredientAggQuantityMap.keySet().iterator();
        while (iter.hasNext()) {
            Ingredient ingredient = (Ingredient) iter.next();
            int aggQuantity = ingredientAggQuantityMap.get(ingredient);
            if (aggQuantity != 0) {
                //    an orderline needs int vendor_id, int order_id, int supplier_id, String ingredient_name, double finalprice, int quantity, double bufferpercentage        //A OrderLine will have int vendor_id;int order_id;int supplier_id;String ingredient_name;double finalprice;int quantity;double bufferpercentage;
                Orderline orderline = new Orderline(vendor_id, order_id, ingredient.getSupplier_id(), ingredient.getName(), UtilityController.convertStringtoDouble(ingredient.getOfferedPrice()) * (double) aggQuantity, aggQuantity, 0.0);
                orderlineList.add(orderline);
            }

        }
        //for debugging purpose
        System.out.println(orderlineList.toString());
        return orderlineList;
    }

    public ArrayList<Orderline> createOrderlineList(HashMap<Ingredient, Integer> ingredientAggQuantityMap, int vendor_id, int order_id, int bufferqtyperc) {
        ArrayList<Orderline> orderlineList = new ArrayList<Orderline>();

        //iterate through ingredientAggQuantityMap
        Iterator iter = ingredientAggQuantityMap.keySet().iterator();
        while (iter.hasNext()) {
            Ingredient ingredient = (Ingredient) iter.next();
            //Adding bufferqty percentage into the aggregate quantity
            double bufferqtymultiplier = bufferqtyperc / 100.0 + 1;
            int aggQuantity = (int) Math.ceil(ingredientAggQuantityMap.get(ingredient) * bufferqtymultiplier);
            if (aggQuantity != 0) {
                //    an orderline needs int vendor_id, int order_id, int supplier_id, String ingredient_name, double finalprice, int quantity, double bufferpercentage        //A OrderLine will have int vendor_id;int order_id;int supplier_id;String ingredient_name;double finalprice;int quantity;double bufferpercentage;
                Orderline orderline = new Orderline(vendor_id, order_id, ingredient.getSupplier_id(), ingredient.getName(), UtilityController.convertStringtoDouble(ingredient.getOfferedPrice()) * (double) aggQuantity, aggQuantity, bufferqtyperc);
                orderlineList.add(orderline);
            }
        }
        //for debugging purpose
        System.out.println(orderlineList.toString());
        return orderlineList;
    }

    public HashMap<Supplier, ArrayList<Orderline>> createSupplierOrderlineMap(ArrayList<Orderline> orderlineList) {
        HashMap<Supplier, ArrayList<Orderline>> supplierOrderlineListMap = new HashMap<Supplier, ArrayList<Orderline>>();

        //iterate through orderlineList
        for (Orderline orderline : orderlineList) {
            Supplier supplier = UserDAO.getSupplierById(orderline.getSupplier_id());

            //do polling of map
            if (!supplierOrderlineListMap.containsKey(supplier)) {
                ArrayList<Orderline> mapOrderlineList = new ArrayList<Orderline>();
                mapOrderlineList.add(orderline);
                supplierOrderlineListMap.put(supplier, mapOrderlineList);
            } else {
                ArrayList<Orderline> mapOrderlineList = supplierOrderlineListMap.get(supplier);
                mapOrderlineList.add(orderline);
                supplierOrderlineListMap.put(supplier, mapOrderlineList);
            }
        }
        //for debugging purpose
        System.out.println(supplierOrderlineListMap.toString());
        return supplierOrderlineListMap;
    }

    public HashMap<Supplier, Order> createSupplierOrderMap(HashMap<Supplier, ArrayList<Orderline>> supplierOrderlineMap, int order_id, int vendor_id) {
        HashMap<Supplier, Order> supplierOrderMap = new HashMap<Supplier, Order>();

        //iterate through dishQuantityMap
        Iterator iter = supplierOrderlineMap.keySet().iterator();
        while (iter.hasNext()) {
            Supplier supplier = (Supplier) iter.next();
            ArrayList<Orderline> orderlineList = supplierOrderlineMap.get(supplier);
            String status = "pending";
            //  order has int order_id, int vendor_id, double total_final_price, Date dt_order, ArrayList<Orderline> orderlines) {
            Order order = new Order(order_id, vendor_id, createAggFinalPrice(orderlineList), new Date(), status, orderlineList);
            supplierOrderMap.put(supplier, order);
            //to compensate for subsequent orders, so that there would be no duplication
            order_id += 1;
        }
        //for debugging purpose
        System.out.println(supplierOrderMap.toString());
        return supplierOrderMap;
    }

    public static double createAggFinalPrice(ArrayList<Orderline> orderlineList) {
        double aggFinalPrice = 0.0;
        for (Orderline orderline : orderlineList) {
            aggFinalPrice += orderline.getFinalprice();
        }
        return aggFinalPrice;
    }

    public static int getLatestOrderID() {
        int latest = 0;
        ArrayList<Order> orderList = retrieveAllOrderList();
        for (Order order : orderList) {
            int order_id = order.getOrder_id();
            if (latest < order_id) {
                latest = order_id;
            }
        }
        return latest;
    }

    public static ArrayList<Order> retrieveAllOrderList() {
        return OrderDAO.retrieveAllOrderList();
    }

    public static Order retrieveOrderByID(int order_id) {
        return OrderDAO.retrieveOrderByID(order_id);
    }

    public static ArrayList<Order> retrieveOrderList(int vendor_id) {
        return OrderDAO.retrieveOrderList(vendor_id);
    }

    public static ArrayList<Orderline> retrieveOrderLineList(int vendor_id, int order_id) {
        return OrderDAO.retrieveOrderLineList(vendor_id, order_id);
    }

    public static void addOrder(Order order) {
        OrderDAO.addOrder(order);
    }

    public static void updateOrder(Order order) {
        OrderDAO.updateOrder(order);
    }

    public static void deleteOrder(Order order) {
        OrderDAO.deleteOrder(order);
    }

//  --------------------------------------------------------  ANALYTICS --------------------------------------------------------
//Make a data table that consists on specified vendor --> order sales total
//    public static String getDishOrderDataTable(int vendor_id) {
//        String stringReturn = "[";
//        ArrayList<Order> orderList = OrderController.retrieveOrderList(vendor_id);
//        
//       //Need to group the suppliers and amount of sales together
//       HashMap<Order,Integer> vendorSupplierOrder = new HashMap<Order,Integer>(); 
//        for (Order order : orderList) {
//              ArrayList<Orderline> orderlineList = order.getOrderlines();
//              for(Orderline orderline: orderlineList){
//                  Supplier supplier = UserController.retrieveSupplierByID(orderline.getSupplier_id());
//                  double sales = orderline.getFinalprice();
//                  //Polling and input inside hashmap
//                  if(!vendorSupplierOrder.containsKey(supplier)){
//                      vendorSupplierOrder.put(supplier, sales);
//                  } else{
//                      vendorSupplierOrder.put(supplier, vendorSupplierOrder.get(supplier)+sales);
//                  }
//              }
//        }
//        
//        //Put the hashmap into data table values
//        Iterator iter = vendorSupplierSales.keySet().iterator();
//        while(iter.hasNext()){
//            Supplier supplier = (Supplier)iter.next();
//            double totalSales = vendorSupplierSales.get(supplier);
//            
//            String content = "\"" + supplier.getSupplier_name() + "\"";
//            String salesOrderStr = "{v: " + totalSales + ", f: '" + String.format("%1$,.2f", totalSales) + "'}";
//            String wrapContent = "[" + content + "," + salesOrderStr + "],";
//            stringReturn += wrapContent;
//        }
//
//        stringReturn = stringReturn.substring(0, stringReturn.length() - 1);
//        stringReturn = stringReturn + "]";
//        System.out.println(stringReturn);
//        return stringReturn;
//    }
//Make a data table that consists on specified vendor --> order sales total
    public static String getSupplierSalesAmountDataTable(int vendor_id) {
        String stringReturn = "[";
        ArrayList<Order> orderList = OrderController.retrieveOrderList(vendor_id);

        //Need to group the suppliers and amount of sales together
        HashMap<Supplier, Double> vendorSupplierSales = new HashMap<Supplier, Double>();
        for (Order order : orderList) {
            ArrayList<Orderline> orderlineList = order.getOrderlines();
            for (Orderline orderline : orderlineList) {
                Supplier supplier = UserController.retrieveSupplierByID(orderline.getSupplier_id());
                double sales = orderline.getFinalprice();
                //Polling and input inside hashmap
                if (!vendorSupplierSales.containsKey(supplier)) {
                    vendorSupplierSales.put(supplier, sales);
                } else {
                    vendorSupplierSales.put(supplier, vendorSupplierSales.get(supplier) + sales);
                }
            }
        }

        //Put the hashmap into data table values
        Iterator iter = vendorSupplierSales.keySet().iterator();
        while (iter.hasNext()) {
            Supplier supplier = (Supplier) iter.next();
            double totalSales = vendorSupplierSales.get(supplier);

            String content = "\"" + supplier.getSupplier_name() + "\"";
            String salesOrderStr = "{v: " + totalSales + ", f: '" + String.format("%1$,.2f", totalSales) + "'}";
            String wrapContent = "[" + content + "," + salesOrderStr + "],";
            stringReturn += wrapContent;
        }

        stringReturn = stringReturn.substring(0, stringReturn.length() - 1);
        stringReturn = stringReturn + "]";
        System.out.println(stringReturn);
        return stringReturn;
    }

//Make a data table that consists on Vendor --> number of Orders
    public static String getVendorOrderDataTable() {
        String stringReturn = "[";
        ArrayList<Vendor> vendorList = UserDAO.retrieveVendorList();
        for (Vendor vendor : vendorList) {
            String content = "\"" + vendor.getVendor_name() + "\"";
            int quantityOrder = retrieveOrderList(vendor.getVendor_id()).size();
            String wrapContent = "[" + content + "," + quantityOrder + "],";
            stringReturn += wrapContent;
        }
        stringReturn = stringReturn.substring(0, stringReturn.length() - 1);
        stringReturn = stringReturn + "]";
        System.out.println(stringReturn);
        return stringReturn;
    }

    //Make a data table that consists on Vendor --> order sales total
    public static String getVendorSalesDataTable() {
        String stringReturn = "[";
        ArrayList<Vendor> vendorList = UserDAO.retrieveVendorList();
        for (Vendor vendor : vendorList) {
            String content = "\"" + vendor.getVendor_name() + "\"";
            double salesOrder = 0.0;
            for (Order order : retrieveOrderList(vendor.getVendor_id())) {
                salesOrder += order.getTotal_final_price();
            }
            //Sales order string needs to be {v: 10000, f: '$10,000'}
            String salesOrderStr = "{v: " + salesOrder + ", f: '" + String.format("%1$,.2f", salesOrder) + "'}";
            String wrapContent = "[" + content + "," + salesOrderStr + "],";
            stringReturn += wrapContent;
        }
        stringReturn = stringReturn.substring(0, stringReturn.length() - 1);
        stringReturn = stringReturn + "]";
        System.out.println(stringReturn);
        return stringReturn;
    }

    //Make a data table that consists on Date --> order count sales total
    public static String getDateOrderDataTable() {
        String stringReturn = "[";
        ArrayList<Vendor> vendorList = UserDAO.retrieveVendorList();
        TreeMap<Date, Integer> dateCountMap = new TreeMap<Date, Integer>();
        for (Vendor vendor : vendorList) {
            String content = "\"" + vendor.getVendor_name() + "\"";
            double salesOrder = 0.0;
            for (Order order : retrieveOrderList(vendor.getVendor_id())) {
                Date date = order.getDtOrder();
                if (dateCountMap.containsKey(date)) {
                    dateCountMap.put(date, dateCountMap.get(date) + 1);
                } else {
                    dateCountMap.put(date, 1);
                }
            }

            //Iterate through the treemap
            Iterator iter = dateCountMap.keySet().iterator();
            while (iter.hasNext()) {
                Date date = (Date) iter.next();
                int counts = dateCountMap.get(date);
                //It needs to be like[new Date(2015, 0, 1), 5]
                String dateOrderStr = "new Date(" + date.getYear() + ", " + date.getMonth() + "," + date.getDate() + ")";
                String wrapContent = "[" + dateOrderStr + "," + counts + "],";
                stringReturn += wrapContent;

            }

        }
        stringReturn = stringReturn.substring(0, stringReturn.length() - 1);
        stringReturn = stringReturn + "]";
        System.out.println(stringReturn);
        return stringReturn;
    }

    public static ArrayList<Order> getSupplierOrders(int suppID) {
        ArrayList<Integer> suppOrdList = OrderDAO.retrieveSupplierOrders(suppID);
        ArrayList<Order> ordList = new ArrayList<Order>();
        for (Integer i : suppOrdList) {
            ordList.add(OrderDAO.retrieveOrderByID(i));
        }
//        for (Integer i : suppOrdList) {
//            Order o = OrderDAO.retrieveOrderByID(i);
//            if (o.getStatus().toLowerCase().equals("pending")) {
//                ordList.add(o);
//            }
//        }

        return ordList;
    }

    public static void updateOrdStatus(int order_id, String status) {
        OrderDAO.updateOrderStatus(order_id, status);
    }
}
