
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Recipe Builder</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
                $.get("ingredientservlet", {dish_id: "<%=request.getParameter("dish_id")%>"}, function(responseText) {
                    $("#ingredientListAdded").append(responseText);
                });
                $('.create-ingredient-button').click(function() {
                    //show modal button
                    $('#modaldiv').modal('show');
                });

            });

        </script>
        <!--CSS-->
        <!--for general CSS please refer to the main css. For others, please just append the link line below-->
        <link rel="stylesheet" type="text/css" href="css/main.css">

    </head>
    <body class="background">


        <div class="transparency">

            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                <h1>Ingredient List</h1>
                <ul id="ingredientListAdded">
                </ul>

                <!--MODAL DIV-->
                <button type="submit" name="submit" class="ui teal button create-ingredient-button">Order now</button>

                <div id="modaldiv" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Add Ingredients
                    </div>
                    <div class="content">
                        <form id="addIngredient" class="ui form" action="ingredientservlet" method="get"> 
                            <!--User inputs attributes-->
                            <label for="name">Ingredient Name :</label>
                            <input id="name" type="text" name="name"/>
                            <label for="subcategory">Sub category: </label>
                            <input id="subcategory" type="text" name="subcategory" />
                            <label for="quantity">Quantity:</label>
                            <input id="quantity" type="number" name="quantity" />
                            <label for="supplyUnit">Unit (g,kg,etc): </label>
                            <input id="supplyUnit" type="text" name="supplyUnit" />
                            <label for="description">Description: </label>
                            <input id="description" type="text" name="description" />
                            <label for="offeredPrice">Price offered: </label>
                            <input id="offeredPrice" type="text" name="offeredPrice" />

                            <!--Input hidden attributes-->
                            <input type="hidden" name="supplier_id" value="1"/> 
                            <input type="hidden" name="vendor_id" value="1">
                            <input type="hidden" name="dish_id" value="<%=request.getParameter("dish_id")%>">

                            <input type="submit" value="Add" class="ui teal button" /> 
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
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>

