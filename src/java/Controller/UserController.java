package Controller;

import DAO.UserDAO;
import Model.Supplier;
import Model.Vendor;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import javamail.EmailController;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userservlet/*")
public class UserController extends HttpServlet {

    @Override
    //doGet will be given to FavouriteSuppliers.jsp
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Will receive vendor id and supplier id interested
        String vendor_idStr = request.getParameter("vendor_id");
        String action = request.getParameter("action");
        String supplier_idStr = request.getParameter("supplier_id");

        String filteredSearchString = "Hello, get here";
        if (!UtilityController.checkNullStringArray(new String[]{vendor_idStr, supplier_idStr})) {
            int vendor_id = UtilityController.convertStringtoInt(vendor_idStr);
            int supplier_id = UtilityController.convertStringtoInt(supplier_idStr);
            if (action.equals("delete")) {
                deleteFavouriteSupplier(vendor_id, supplier_id);
                response.sendRedirect("FavouriteSuppliers.jsp");
            } else if (action.equals("search")) {
                //Give filtered search to be written
                ArrayList<Supplier> supplierList;
                //if word is null then give all the list, if word is there then do a filter function
                String word = request.getParameter("word");
                if (word == null || word.isEmpty()) {
                    //get the list of suppliers
                    supplierList = retrieveSupplierList();
                } else {
                    //filter the supplier based on the string word
                    supplierList = filterSupplierBasedOnWord(word);
                }
                //put them into a html table string
                filteredSearchString = retrieveSupplierHTMLTable(vendor_id, supplierList, retrieveSupplierListByVendor(vendor_id));
                //put them into scripts for the buttons
            } else { //create
                saveAsFavouriteSupplier(vendor_id, supplier_id);
                response.sendRedirect("FavouriteSuppliers.jsp");
            }
        }

        response.setContentType(
                "text/plain");  // Set content type of the response so that AJAX knows what it can expect.
        response.setCharacterEncoding(
                "UTF-8");
        response.getWriter()
                .write(filteredSearchString);       // Write response body.
    }

    @Override
    //doPost will be given to VendorProfile.jsp
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Will receive vendor id and supplier id interested
        String vendor_idStr = request.getParameter("vendor_id");
        String action = request.getParameter("action");

        if (!UtilityController.checkNullStringArray(new String[]{vendor_idStr, action})) {
            int vendor_id = UtilityController.convertStringtoInt(vendor_idStr);
            Vendor vendor = UserController.retrieveVendorByID(vendor_id);
            if (action.equals("editprofile")) {
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String area_code = request.getParameter("area_code");
                String telephone_number = request.getParameter("telephone_number");
                String vendor_description = request.getParameter("vendor_description");
                vendor.setEmail(email);
                vendor.setAddress(address);
                vendor.setArea_code(UtilityController.convertStringtoInt(area_code));
                vendor.setTelephone_number(UtilityController.convertStringtoInt(telephone_number));
                vendor.setVendor_description(vendor_description);
                updateVendor(vendor);
                response.sendRedirect("VendorProfile.jsp");
            } else if (action.equals("editpassword")) {
                String new_password = request.getParameter("new_password");
                vendor.setPassword(new_password);
                updateVendor(vendor);
                response.sendRedirect("VendorProfile.jsp");
            }

            response.setContentType(
                    "text/plain");  // Set content type of the response so that AJAX knows what it can expect.
            response.setCharacterEncoding(
                    "UTF-8");
            response.getWriter()
                    .write("");       // Write response body.
        }
    }

    public String retrieveSupplierHTMLTable(int vendor_id, ArrayList<Supplier> supplierList, ArrayList<Supplier> currentFavSupplier) {
        StringBuffer htmlTable = new StringBuffer("");

        //Create header
        htmlTable.append("<tr>");
        htmlTable.append("<th>Supplier Name</th>");
        htmlTable.append("<th>Supplier Type</th>");
        htmlTable.append("<th>Favorite?</th>");
        htmlTable.append("</tr>");
        for (Supplier supplier : supplierList) {
            htmlTable.append("<tr>");
            htmlTable.append("<td>" + supplier.getSupplier_name() + "</td>");
            htmlTable.append("<td>" + supplier.getSupplier_type() + "</td>");
            if (currentFavSupplier.contains(supplier)) {
                htmlTable.append("<td class=\"favorite\">Favorited</td>");
            } else {
//                htmlTable.append("<td><button class=\"ui inverted red button create-favsupplier-button"+supplier.getSupplier_id()+"\">Favourite this supplier</button></td>");
                htmlTable.append("<td><a href=\"userservlet?vendor_id=" + vendor_id + "&supplier_id=" + supplier.getSupplier_id() + "&action=add\">Make as Favorite</a></td>");
            }
            htmlTable.append("</tr>");
        }
        return htmlTable.toString();
    }

    public ArrayList<Supplier> filterSupplierBasedOnWord(String word) {
        ArrayList<Supplier> returnSupplierList = new ArrayList<Supplier>();
        ArrayList<Supplier> supplierList = retrieveSupplierList();
        String wordLower = word.toLowerCase();
        for (Supplier supplier : supplierList) {
            String nameLower = supplier.getSupplier_name().toLowerCase();
            String typeLower = supplier.getSupplier_type().toLowerCase();
            if (nameLower.contains(wordLower) || typeLower.contains(wordLower)) {
                returnSupplierList.add(supplier);
            }
        }
        return returnSupplierList;
    }

    public static ArrayList<Supplier> retrieveSupplierList() {
        return UserDAO.retrieveSupplierList();
    }

    public static Supplier loginSupplier(String supplier_name, String password) {
        return UserDAO.loginSupplier(supplier_name, password);
    }

    public static void signUpSupplier(Supplier supplier) {
        UserDAO.signUpSupplier(supplier);
    }

    //Input the new/edited vendor (set password or any other information) 
    public static void updateSupplier(Supplier supplier) {
        UserDAO.updateSupplier(supplier);
    }

    public static Supplier retrieveSupplierByID(int supplierID) {
        return UserDAO.getSupplierById(supplierID);
    }

    public static Vendor retrieveVendorByID(int vendorID) {
        return UserDAO.getVendorByID(vendorID);
    }

    public static ArrayList<Vendor> retrieveVendorList() {
        return UserDAO.retrieveVendorList();
    }

    //Input the new/edited vendor (set password or any other information) 
    public static void updateVendor(Vendor vendor) {
        UserDAO.updateVendor(vendor);
    }

    public static Vendor loginVendor(String vendor_name, String password) {
        return UserDAO.loginVendor(vendor_name, password);
    }

    public static void signUpVendor(Vendor vendor) {
        UserDAO.signUpVendor(vendor);
    }

    public static ArrayList<Supplier> retrieveSupplierListByVendor(int vendor_id) {
        return UserDAO.retrieveFavouriteSupplierListByVendor(vendor_id);
    }

    public static void saveAsFavouriteSupplier(int vendor_id, int supplier_id) {
        UserDAO.saveAsFavouriteSupplier(vendor_id, supplier_id);
    }

    public static void deleteFavouriteSupplier(int vendor_id, int supplier_id) {
        UserDAO.deleteFavouriteSupplier(vendor_id, supplier_id);
    }

}
