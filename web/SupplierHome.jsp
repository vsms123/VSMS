<%-- 
    Document   : MainMenu
    Created on : Jan 18, 2016, 1:03:48 PM
    Author     : Benjamin
--%>

<%@page import="Controller.IngredientController"%>
<%@page import="Controller.OrderController"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <%@ include file="protect_supplier.jsp" %>
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            /*Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
             //in case current vendor does not exist
             if (currentVendor == null) {
             currentVendor = UserController.retrieveVendorByID(1);
             }
             int vendor_id = currentVendor.getVendor_id();*/

            Supplier s = (Supplier) session.getAttribute("currentSupplier");
            int pending_count = 0;
            if (s != null) {
                ArrayList<Order> orderList = OrderController.getSupplierOrders(s.getSupplier_id());

                for (Order o : orderList) {
                    if (o.getStatus().equals("pending")) {
                        pending_count++;
                    }
                }
            }
        %>
        <script>
            $(document).ready(function () {
                $('.message').click(function () {
                    //show modal button
                    $('#modalMessage').modal('show');
                });
                $('.profile').click(function () {
                    //show modal button
                    $('#modalAccount').modal('show');
                });

//              //For mobile view, will implement later
//                $(window).on('load resize', function () {
//                    var width = $(window).width();
//                    var height = $(window).height();
//
//                    if ((width <= 800) || (height <= 600)) {
//                        $("#pc").css("display", "none");
//                        $("#mobile").css("display", "");
//                    } else {
//                        
//                        $("#mobile").css("display", "none");
//                        $("#pc").css("display", "");
//                    }
//                });

            });
        </script>


        <script>
            $(document).ready(function () {
                $('#testing').click(function () {
                    $('.vertical.menu').sidebar('toggle');
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                $("#testing").click(function () {
                    $('.vertical.menu').sidebar('toggle');
                });

            });
        </script>



        <title>Main Menu</title>
    </head>



    <body>

        <div id="pc" class="background">


            <div class="transparency">


                <div  class="ui segment" style="left:5%;width:90%">

                    <%@ include file="SuppNavbar.jsp" %>

                    <p></p>


                    <div class="ui raised very padded text container">
                        <p></p>
                        <h1 class="ui header">VSMS Supplier Menu</h1>

                        <p></p>
                        <!--<h1>This is the SUPPLIER homepage </h1>-->
                        <h1>Welcome, <% if (s != null) {%> <%=s.getSupplier_name()%> <%}%></h1>
                        <h2>You have <a href="SupplierReviewOrders.jsp"><%=pending_count%></a> pending orders.</h2>

                    </div>
                    </body>
                    </html>
