
<%@page import="Controller.UtilityController"%>
<%@page import="java.util.Iterator"%>
<%@page import="Model.Ingredient"%>
<%@page import="java.util.HashMap"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Recipe Builder</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <%
            //To query Dish to be attached with an <Ingredient,IngredientQuantity> HashMap
            String dish_idStr = request.getParameter("dish_id");
            HashMap<Ingredient, ArrayList<String>> ingredientList = IngredientController.getIngredientQuantity(dish_idStr);
            Iterator iter = ingredientList.keySet().iterator();

        %>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
                $.get("ingredientservlet", {dish_id: "<%=request.getParameter("dish_id")%>"}, function(responseText) {
                    $("#ingredientListAdded").append(responseText);
                });
                $('.create-ingredient-button').click(function() {
                    //Change the url
                    window.location = "IngredientSearch.jsp?dish_id=<%=dish_idStr%>";
                });
            <% while (iter.hasNext()) {
                    Ingredient ingredient = (Ingredient) iter.next();
                    int supplier_id = ingredient.getSupplier_id();
                    String name = ingredient.getName();
                    String identification = supplier_id + "-" + name;
                    identification = identification.replace(" ", "_");
                    ArrayList<String> stringArray = ingredientList.get(ingredient);

            %>
                $(".delete-ingredient-button<%=identification%>").click(function() {

                    console.log("My name is delete-dish-button<%=identification%>");
                    //show modal button
                    $('#deletemodaldiv<%=identification%>').modal('show');
                });
            <%}
                //Refreshing iterator for later use
                iter = ingredientList.keySet().iterator();
            %>
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

                <h1><%=IngredientController.getDishByID(UtilityController.convertStringtoInt(dish_idStr)).getDish_name()%></h1>
                <table>
                    <% while (iter.hasNext()) {
                            Ingredient ingredient = (Ingredient) iter.next();
                            int supplier_id = ingredient.getSupplier_id();
                            String name = ingredient.getName();
                            String identification = supplier_id + "-" + name;
                            identification = identification.replace(" ", "_");
                            ArrayList<String> stringArray = ingredientList.get(ingredient);

                    %>
                    <tr>
                        <td><%=ingredient%></td>
                        <td><%=stringArray%></td>
                        <td><button class="ui red inverted button delete-ingredient-button<%=identification%>"> <i class="remove icon"></i>Delete Ingredient</button></td>
                    </tr>
                    <% }//Refreshing iter for later use               
                        iter = ingredientList.keySet().iterator();
                    %>
                </table>

                <!--MODAL DIV-->
                <button type="submit" name="submit" class="ui teal button create-ingredient-button">Add Ingredient</button>

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
                <!--Create many modals for each ingredient to be deleted-->
                <% while (iter.hasNext()) {
                        Ingredient ingredient = (Ingredient) iter.next();
                        int supplier_id = ingredient.getSupplier_id();
                        String name = ingredient.getName();
                        String identification = supplier_id + "-" + name;
                        identification = identification.replace(" ", "_");
                        ArrayList<String> stringArray = ingredientList.get(ingredient);

                %>
                <div id="deletemodaldiv<%=identification%>" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Delete Dish
                    </div>

                    <div class="content">
                        <form class="ui form" id="deleteIngredient" action="ingredientservlet" method="get"> 
                            <!--Inserting delete danger message. -->

                            Are you sure you would like to delete the ingredient?

                            <!--Input hidden attributes-->
                            <input type="hidden" name="name" value="<%=ingredient.getName()%>">
                            <input type="hidden" name="supplier_id" value="<%=ingredient.getSupplier_id()%>">
                            <input type="hidden" name="dish_id" value="<%=dish_idStr%>">
                            <input type="hidden" name="vendor_id" value="1">
                            <input type="hidden" name="action" value="delete">

                            <input type="submit" value="Delete" class="ui teal button" /> 
                        </form>
                    </div>
                    <div class="actions">
                        <div class="ui positive right labeled icon button">
                            <a class="text-white" href="<?php echo site_url('home/order');?>">Back to Home</a>
                            <i class="checkmark icon"></i>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>

<!--JAVASCRIPT-->
<!--for general Javascript please refer to the main js. For others, please just append the script line below-->
<script src="js/main.js" type="text/javascript"></script>
</body>
</html>

