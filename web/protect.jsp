<%-- 
    Document   : Validation
    Created on : Jan 31, 2016, 5:01:37 PM
    Author     : Benjamin
--%>

<%@page import="Model.Supplier"%>
<%@page import="Model.Vendor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
            Supplier currentSupplier = (Supplier) session.getAttribute("currentSupplier");
            if (currentVendor == null && currentSupplier == null) {
                session.setAttribute("errorMsg", "Not Logged In");
                response.sendRedirect("Login.jsp");
                return;
            } 
        %>


    </body>
</html>
