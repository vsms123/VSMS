<%-- 
    Document   : VendorProfile
    Created on : Jan 23, 2016, 10:59:24 AM
    Author     : David
--%>

<%@page import="Model.Vendor"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Favourite Suppliers</title>
    </head>
    <body>
        <h1>Favourite Supplier</h1>
        <%
             Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
             
            //ID=session.getAttribute(vendor_id);
            ArrayList<Supplier> favSupplierList=UserController.retrieveSupplierListByVendor(currentVendor.getVendor_id());
            for(Supplier supplier:favSupplierList){
                %><%=supplier.getSupplier_name()%><%
                %><%=supplier.getSupplier_description()%><%
                %><%=supplier.getEmail()%><%
            }
        %>
    </body>
</html>
