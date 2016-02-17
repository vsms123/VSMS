<%-- 
    Document   : TemplateMain
    Created on : Feb 17, 2016, 10:02:46 PM
    Author     : David
--%>

<%@page import="Model.OrderTemplate"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
            //in case current vendor does not exist
            if (currentVendor == null) {
                currentVendor = UserController.retrieveVendorByID(1);
            }

            ArrayList<OrderTemplate> templates=OrderDAO.retrieveOrderTemplates(currentVendor.getVendor_id());
            for (OrderTemplate template:templates){
        %>
        <a href="OrderTemplate.jsp?orderId=<%=template.getOrder_id()%>"><%=template.getName()%></a><br>
        <%
        }
        %>
        <a href="CreateTemplate.jsp">Create New Template</a>
    </body>
</html>
