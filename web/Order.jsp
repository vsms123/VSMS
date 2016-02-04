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
                $.post("orderservlet", function(responseText) {
                    $("#orderListTable").append(responseText);
                });
            });
        </script>

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

                <form class="ui form" id="addOrder" action="orderservlet" method="post"> 
                    <!--Inputting form elements-->

                    <!--This table will send all the dishid info (textbox) with the dish_count as hidden parameter-->
                    <table id="orderListTable">
                        <% ArrayList<Dish> dishList = IngredientController.getDish("1");
                            for (Dish dish : dishList) {%>
                        <tr>
                            <td><h2><label for= "dish<%=dish.getDish_id()%>"> <%=dish.getDish_name()%></label></h2></td>
                            <td><input type="number" value=1 name="dish<%=dish.getDish_id()%>" id="dish<%=dish.getDish_id()%>"/></td>
                        </tr>
                        <%}%>
                    </table>
                    <!--Input hidden attributes-->
                    <input type="hidden" name="vendor_id" value="1"/>
                    <br/>
                    <input type="submit" value="Add" class="ui big teal button" />
                </form>

            </div>
        </div>

        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
