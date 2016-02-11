<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Order</title>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
                    $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code

            <%
                String vendor_idStr = "1";
                ArrayList<Dish> dishList = IngredientController.getDish(vendor_idStr);
                // Key up to send and populate the modal of orderline confirmations                   
                //Adding the value confirmation into model table and send the orders.
                String valueStr = "";

                for (Dish dish : dishList) {
                    valueStr += "," + "dish" + dish.getDish_id() + ":" + "$('#ordervalue" + dish.getDish_id() + "').val()";
                }
                for (Dish dish : dishList) {
            %>

            $("#ordervalue<%=dish.getDish_id()%>").change(function() {
            console.log("Hey, I am the change dialogue");
                    //Make the value string
                    $.post("orderservlet", {vendor_id:<%=vendor_idStr%>, action: 'confirm' <%=valueStr%>}, function(responseText) {
                    $(".content-model-table").html(responseText);
                    });
            });
            <%}%>
            //Open up the model
            $('.open-order-check').click(function() {
            //Make the value string
            $.post("orderservlet", {vendor_id:<%=vendor_idStr%>, action: 'confirm' <%=valueStr%>}, function(responseText) {
            $(".content-model-table").html(responseText);
            });
                    //show modal button
                    $('#confirmationdiv').modal('show');
            });
                    //Open up the model
                    $("#confirm-order").click(function() {
                        console.log("Confirm order here");
                        //Make ajax load synchronous while loading the order
                            $.ajaxSetup({async:false});
                            $.post("orderservlet", {vendor_id:<%=vendor_idStr%>, action: 'add'<%=valueStr%>}, function(responseText) {});
                            alert("Order has been made");
                            $('#confirmationdiv').modal('hide');
                    });
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
                    <i class="right angle icon divider"></i>
                    <a href="" class="section">Order</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Make an Order</div>
                </div>
                <h1 style="color: black">Order</h1>

                <!--Inputting form elements-->

                <!--This table will send all the dishid info (textbox) with the dish_count as hidden parameter-->
                <table id="orderListTable">
                    <%
                        for (Dish dish : dishList) {%>
                    <tr>
                        <td><h2><label for= "dish<%=dish.getDish_id()%>"> <%=dish.getDish_name()%></label></h2></td>
                        <td><input type="number" value=1 name="dish<%=dish.getDish_id()%>" id="ordervalue<%=dish.getDish_id()%>"/></td>
                    </tr>
                    <%}%>
                </table>
                <!--Input hidden attributes-->
                <input type="hidden" name="vendor_id" value="1"/>
                <br/>
                <!--Input button to a modal here + the modal-->
                <!--MODAL DIV-->
                <div id="confirmationdiv" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Check Order
                    </div>
                    <div class="content-model-table">                            
                    </div>
                    <div class="actions">
                        <button id="confirm-order" class="ui big teal button">Confirm</button>
                        <div class="ui positive right labeled icon button">
                            <a class="text-white" href="<?php echo site_url('home/order');?>">Back to Home</a>
                            <i class="checkmark icon"></i>
                        </div>
                    </div>
                </div>
                <button class="ui red inverted button open-order-check"> <i class="remove icon"></i>Check Order</button>


            </div>
        </div>

        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just html the script line below-->
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
