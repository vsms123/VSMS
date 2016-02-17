<%-- 
    Document   : OrderTemplate
    Created on : Feb 12, 2016, 1:48:50 PM
    Author     : David
--%>

<%@page import="Controller.UtilityController"%>
<%@page import="Model.Dish"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="Model.OrderTemplate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Vendor"%>
<%@page import="Controller.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <h1>There can probably be a list of order templates shown here</h1>
        <!--Displays an order template-->
        <%
           Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
            //in case current vendor does not exist
            if (currentVendor == null) {
                currentVendor = UserController.retrieveVendorByID(1);
            }
            
            %>
                <form action="OrderBreakdown.jsp" method="get">
                        <table >
                            <tr><td>Dish Name</td><td>Dish Quantity</td></tr>
            <%
            
            ArrayList<OrderTemplate> templates=OrderDAO.retrieveOrderTemplates(currentVendor.getVendor_id());
            String orderId=request.getParameter("orderId");
            for(OrderTemplate template:templates){
                if(template.getOrder_id()==UtilityController.convertStringtoInt(orderId)){
                ArrayList<Dish> dishList=template.getDishList();
                ArrayList<Integer> intList=template.getStringList();
                for(int i=0;i<dishList.size();i++){
                    Dish dish=dishList.get(i);
                    int num=intList.get(i);
                    %>
                    
                            <tr>
                                <td><h2><label for= "dish<%=dish.getDish_id()%>"> <%=dish.getDish_name()%></label></h2></td>
                                <td><input type="number" value=<%=num%> name="dish<%=dish.getDish_id()%>" id="ordervalue<%=dish.getDish_id()%>"/></td>
                            </tr>
                    <%
                }
                }
            }
            %>
                </table>
                <input type="hidden" name="vendor_id" value="1"/>
                <button type="submit" class="ui green large button" name="submit" id="submit"/><i class="checkmark icon"></i>Place Order</button>
            </form>  
            <%
        %>    
        <!--End displaying an order template-->
    </body>
</html>
