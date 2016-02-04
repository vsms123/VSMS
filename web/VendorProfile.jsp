<%-- 
    Document   : VendorProfile
    Created on : Feb 4, 2016, 7:20:40 PM
    Author     : Benjamin
--%>

<%@page import="Model.Vendor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vendor Profile</title>
    </head>
    <body class="background">


        <div class="transparency">

            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                <h1>Vendor Profile</h1>
                <%
                    Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");

                %>
                <%=currentVendor.getVendor_name()%>
                <br/>
                <%=currentVendor.getVendor_description()%><%


                %>

            </div>
        </div>
    </body>
</html>
