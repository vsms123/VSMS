<!-- ****************************************************************** -->
<!--THIS IS ACCESSED BY THE SUPPLIER/ NO SESSION and PROTECT IS NECESSARY-->
<!-- ****************************************************************** -->
<%@page import="Model.Order"%>
<%@page import="Controller.OrderController"%>
<%@page import="Controller.UtilityController"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Order Confirmation</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>

        <!--CSS-->
        <!-- Import CDN for semantic UI -->    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
        <!--for general CSS please refer to the main css. For others, please just append the link line below-->
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
                $('.approve-order-button').click(function() {
                    console.log("My name is approve-order-button");

                    //show modal button
                    $('#approvemodaldiv').modal('show');
                });
                $('.reject-order-button').click(function() {
                    console.log("My name is reject-order-button");

                    //show modal button
                    $('#rejectmodaldiv').modal('show');
                });
            });

        </script>
    </head>
    <body class="background">
        <div class="transparency">
            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                <div class="ui breadcrumb" >
                    <a class="section">Home</a>
                    <i class="right angle icon divider"></i>
                    <a class="section">Manage Menu</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Recipe Buider</div>
                </div>
                <h1>Your Order</h1>
                <%
                    String order_idStr = request.getParameter("order_id");
                    int order_id = UtilityController.convertStringtoInt(order_idStr);
                    Order order = OrderController.retrieveOrderByID(order_id);
                %>

                <h4><%=order%></h4>

                <h2>Would you like to approve?</h2>

                <button class="ui red basic button approve-order-button">Approve</button>
                <button class="ui red basic button reject-order-button">Reject</button>                        

                <!--Modal for approving-->
                <div id="approvemodaldiv" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Approve Dish
                    </div>

                    <div class="content">
                        <form id="approveOrder" action="orderservlet" method="get"> 
                            <!--Inserting approve confirmation message. -->
                            Are you sure you would like to approve the order?

                            <!--Input hidden attributes-->
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="order_id" value="<%=order_id%>">

                            <input type="submit" value="Approve" class="ui teal button" /> 
                        </form>
                    </div>
                    <div class="actions">
                        <div class="ui positive right labeled icon button">
                            <a class="text-white" href="<?php echo site_url('home/order');?>">Back to Home</a>
                            <i class="checkmark icon"></i>
                        </div>
                    </div>
                </div>

                <!--Modal for rejecting-->
                <div id="rejectmodaldiv" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Reject Order
                    </div>

                    <div class="content">
                        <form id="rejectOrder" action="orderservlet" method="get"> 
                            <!--Inserting reject danger message. -->

                            Are you sure you would like to reject the order?

                            <!--Input hidden attributes-->
                            <input type="hidden" name="action" value="reject">
                            <input type="hidden" name="order_id" value="<%=order_id%>">

                            <input type="submit" value="Reject" class="ui teal button" /> 
                        </form>
                    </div>
                    <div class="actions">
                        <div class="ui positive right labeled icon button">
                            <a class="text-white" href="<?php echo site_url('home/order');?>">Back to Home</a>
                            <i class="checkmark icon"></i>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
