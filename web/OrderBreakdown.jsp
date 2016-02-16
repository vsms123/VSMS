<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Controller.UtilityController"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Breakdown</title>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <!--OrderBreakdown.jsp will receive vendor_id:, action: confirm and the list of dishid with their values-->
        <%
            String vendor_idStr = request.getParameter("vendor_id");
            String action = request.getParameter("action");
            ArrayList<Dish> dishList = IngredientController.getDish(vendor_idStr);
            //    Empty String to contain POST AJAX String of Dish Quantity List
            String valueStr = "";

            for (Dish dish : dishList) {
                valueStr += "," + "dish" + dish.getDish_id() + ":" + request.getParameter("dish" + dish.getDish_id());
            }
        %>
        <script>
                    $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
            //Hide AJAX Loading Message
            $("#loading").hide();
                    //Generate the order breakdown
                    $.post("orderservlet", {vendor_id:<%=vendor_idStr%>, action: 'confirm' <%=valueStr%>}, function(responseText) {
                    $(".content-model-table").html(responseText);
                    });
                    //Regenerate the order breakdown when bufferQtyTextbox is changed
                    $("#bufferqtyperc").change(function() {
            //Make the value string
            $.post("orderservlet", {vendor_id:<%=vendor_idStr%>, action: 'confirm', bufferqtyperc : $('#bufferqtyperc').val() <%=valueStr%>}, function(responseText) {
            $(".content-model-table").html(responseText);
            });
            });
                    //Confirm the order breakdown
                    $("#confirm-order-breakdown").click(function() {
                    $("#loading").show();
                    console.log("Sending order breakdown");
                    //Timeout is used to make sure that the loading text is shown first before the synchronous ajax kicks
//                    Synchronous ajax is used to make sure that the order processing could be done with a fixed buffer quantity
                    setTimeout(function() {$.ajaxSetup({async:false});
                    $.post("orderservlet", {vendor_id:<%=vendor_idStr%>, action: 'create', bufferqtyperc : $('#bufferqtyperc').val() <%=valueStr%>}, function(responseText) {                    });
                    alert("Order has been sent to suppliers");
                    },1000);
            });
            });
            //T
                    $(document).ajaxStart(function() {
            $("#loading").show();
            });
                    $(document).ajaxStop(function() {
            $("#loading").hide();
            });</script>

        <!--CSS-->
        <!-- Import CDN for semantic UI -->    

    </head>
    <body class="background">


        <div class="transparency">


            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                <div class="ui breadcrumb" >
                    <a href="Home.jsp" class="section">Home</a>
                    <i class="right angle icon divider"></i>-
                    <a href="" class="section">Order</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">View Order Breakdown</div>
                </div>
                <h1 style="color: black">Order Breakdown</h1>

                <!--Inputting form elements-->
                <h2><label for= "bufferqtyperc"> Buffer Quantity (in Percentage)</label></h2>
                <div class="ui right labeled input">
                    <input type="number" value=0 name="bufferqtyperc" id="bufferqtyperc"/>
                    <div class="ui basic label">
                        %
                    </div>
                </div>
                <button class="ui red inverted button" id="confirm-order-breakdown"> <i class="remove icon"></i>Confirm Order Breakdown</button>
                <p id="loading"><font color="red">Your request is loading...</font></p>
                <hr>

                <!--This table will send all the dishid info (textbox) with the dish_count as hidden parameter-->
                <div class="content-model-table">                            
                </div>


            </div>
        </div>

        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just html the script line below-->
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
