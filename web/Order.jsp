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

        <%
            String vendor_idStr = "1";
            ArrayList<Dish> dishList = IngredientController.getDish(vendor_idStr);
        %>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code

            }
        </script>

        <!--CSS-->
        <!-- Import CDN for semantic UI -->    

    </head>
    <body class="background">
        <div class="transparency">
            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>

                <h1 style="color: black">Order</h1>

                <!--Inputting form elements-->

                <form action="OrderBreakdown.jsp" method="get">
                    <!--This table will send all the dishid info (textbox) with the dish_count as hidden parameter-->




                    <div class="ui middle aligned divided list">

                        <%
                            for (Dish dish : dishList) {
                        %>
                        <div style="color:black" id="orderListTable" class="item test dish" data-content="Click to view/edit dish"  data-variation="inverted">
                            <div class="right floated content">


                                <div class="ui large input">
                                    <input type="number" value=1 placeholder="quantity.." name="dish<%=dish.getDish_id()%>" id="ordervalue<%=dish.getDish_id()%>">&nbsp;
                                </div>
                            </div>
                            <div>
                                <div class="content">
                                    &nbsp<h2><label for= "dish<%=dish.getDish_id()%>"> <%=dish.getDish_name()%></h2>
                                </div>
                            </div>

                        </div>
                        <%}%>
                        <!--Input hidden attributes-->
                        <input type="hidden" name="vendor_id" value="1"/>
                        <br/>

                        <button type="submit" class="ui green large button" name="submit" id="submit"/><i class="checkmark icon"></i>Check Order Breakdown </button>

                    </div>
                </form>

            </div>

            <!--JAVASCRIPT-->
            <!--for general Javascript please refer to the main js. For others, please just html the script line below-->
            <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
