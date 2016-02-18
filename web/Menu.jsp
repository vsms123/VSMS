<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
         <%
                    Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
                    if (currentVendor == null) {
                        currentVendor = UserController.retrieveVendorByID(1);
                    }
        %>
        <title>Menu</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
                $.post("ingredientservlet", function(responseText) {
                    $("#dishListAdded").append(responseText);
                });
                $('.create-dish-button').click(function() {
                    console.log("My name is create-dish-button");

                    //show modal button
                    $('#createmodaldiv').modal('show');
                });
            <%
                ArrayList<Dish> dishList = IngredientController.getDish("1");
                for (Dish dish : dishList) {
            %>
//              Will go through edit-dish-button1 or edit-dish-button2 (regarding the dish id)
                $(".edit-dish-button<%=dish.getDish_id()%>").click(function() {

                    console.log("My name is edit-dish-button<%=dish.getDish_id()%>");
                    //show modal button
                    $('#editmodaldiv<%=dish.getDish_id()%>').modal('show');
                });
                //              Will go through delete-dish-button1 or delete-dish-button2 (regarding the dish id)
                $(".delete-dish-button<%=dish.getDish_id()%>").click(function() {

                    console.log("My name is delete-dish-button<%=dish.getDish_id()%>");
                    //show modal button
                    $('#deletemodaldiv<%=dish.getDish_id()%>').modal('show');
                });
            <%}%>



                $('.test.dish').popup({
                    position: 'top left'
                });
            });


        </script>
       
    </head>
    <body class="background">


        <div class="transparency">


            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
               
                <h1 style="color: black">Menu</h1>
                <br/>
                <div class="ui middle aligned animated selection divided list">
                    <%for (Dish dish : dishList) {%>


                    <div class="item test dish" data-content="Click to view/edit dish"  data-variation="inverted">
                        <div class="right floated content">


                            <button class="ui green inverted button edit-dish-button<%=dish.getDish_id()%>">Edit</button>
                            <button class="ui red inverted button delete-dish-button<%=dish.getDish_id()%>"> <i class="remove icon"></i>Delete Dish</button>
                        </div>
                        <a href="RecipeBuilder.jsp?dish_id=<%=dish.getDish_id()%>" >
                            <div class="content">
                                <h2><%=dish.getDish_name()%></h2>
                            </div>
                            <div>
                                <%=dish.getDish_description()%>
                            </div>
                        </a>
                    </div>




                    <%}%>
                </div>
                <br/>
                <button class="ui green large button create-dish-button"><i class="plus icon"></i>Create New Dish</button>

                <br/>

                <!--Create a modal for adding the menu-->
                <div id="createmodaldiv" class="ui small modal">

                    <div class="header">
                        Add New Dish to Menu
                    </div>
                    <div class="content">
                        <form id="addDish" class="addDish ui form" action="ingredientservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="dish_name">Dish Name:</label> 
                            <input id="dish_name" type="text" name="dish_name">
                            <label for ="dish_description">Dish Description:</label> 
                            <textarea id="dish_description" name="dish_description"></textarea>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="vendor_id" value="<%=currentVendor.getVendor_id()%>">
                            <input type="hidden" name="action" value="add">
                            <input type="submit" value="Add" class="ui teal button" /> 
                        </form>
                    </div>
                    <div class="actions">

                        <button class="ui inverted deny orange button">Cancel</button>


                    </div>
                </div>


                <!--Create many modals for each dish to be sent-->
                <%
                    for (Dish dish : dishList) {
                %>
                <div id="editmodaldiv<%=dish.getDish_id()%>" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Edit Dish
                    </div>

                    <div class="content">
                        <form class="ui form" action="ingredientservlet" method="post"> 
                            <!--Inputting form elements, already put for -->
                            <label for="dish_name">Dish Name:</label> 
                            <input id="dish_name" type="text" name="dish_name" value="<%=dish.getDish_name()%>">
                            <label for ="dish_description">Dish Description:</label> 
                            <textarea id="dish_description" name="dish_description"><%=dish.getDish_description()%></textarea>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="dish_id" value="<%=dish.getDish_id()%>">
                            <input type="hidden" name="vendor_id" value="<%=currentVendor.getVendor_id()%>">
                            <input type="hidden" name="action" value="edit">

                            <input type="submit" value="Edit" class="ui teal button" /> 
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

                <!--Create many modals for each dish to be sent-->
                <%
                    for (Dish dish : dishList) {
                %>
                <div id="deletemodaldiv<%=dish.getDish_id()%>" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Delete <%=dish.getDish_name()%>
                    </div>

                    <div class="content">
                        <form class="ui form" id="deleteDish" action="ingredientservlet" method="post"> 
                            <!--Inserting delete danger message. -->

                            Are you sure you would like to delete <%=dish.getDish_name()%>?
                            <br>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="dish_name" value="<%=dish.getDish_name()%>">
                            <input type="hidden" name="dish_description" value="<%=dish.getDish_description()%>">
                            <input type="hidden" name="dish_id" value="<%=dish.getDish_id()%>">
                            <input type="hidden" name="vendor_id" value="<%=currentVendor.getVendor_id()%>">
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
            </div>
        </div>
        <%}%>
        <!--JAVASCRIPT-->
        <script>$("#form").validate();</script>
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>

