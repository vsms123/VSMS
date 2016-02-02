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
        <title>Recipe Builder</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        
        <script>
            $(document).ready(function () { // Prepare the document to ready all the dom functions before running this code
                $.post("ingredientservlet", function (responseText) {
                    $("#dishListAdded").append(responseText);
                });
                $('.create-dish-button').click(function () {
                    console.log("My name is create-dish-button");

                    //show modal button
                    $('#createmodaldiv').modal('show');
                });
            <%
                ArrayList<Dish> dishList = IngredientController.getDish("1");
                for (Dish dish : dishList) {
            %>
//              Will go through edit-dish-button1 or edit-dish-button2 (regarding the dish id)
                $(".edit-dish-button<%=dish.getDish_id()%>").click(function () {

                    console.log("My name is edit-dish-button<%=dish.getDish_id()%>");
                    //show modal button
                    $('#editmodaldiv<%=dish.getDish_id()%>').modal('show');
                });
                //              Will go through delete-dish-button1 or delete-dish-button2 (regarding the dish id)
                $(".delete-dish-button<%=dish.getDish_id()%>").click(function () {

                    console.log("My name is delete-dish-button<%=dish.getDish_id()%>");
                    //show modal button
                    $('#deletemodaldiv<%=dish.getDish_id()%>').modal('show');
                });
            <%}%>



                $('.test.dish')
                        .popup({
                            position: 'top left'
                        })

                        ;
            });


        </script>
        <style>
            a:link {
                color: black;
            }

            /* visited link */
            a:visited {
                color: Black;
            }

            /* mouse over link */
            a:hover {
                color: hotpink;
            }

            /* selected link */
            a:active {
                color: black;
            }
        </style>


        <!--CSS-->
        <!-- Import CDN for semantic UI -->    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <!--for general CSS please refer to the main css. For others, please just append the link line below-->
        <link rel="stylesheet" type="text/css" href="css/main.css">

    </head>
    <body class="background">


        <div class="transparency">


            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                <div class="ui breadcrumb" >
                    <a href="Home.jsp" class="section">Home</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Menu</div>
                </div>
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
                    <i class="close icon"></i>
                    <div class="header">
                        Add Dish
                    </div>

                    <div class="content">
                        <form id="addIngredient" action="ingredientservlet" method="post"> 
                            <!--Inputting form elements-->
                            Dish Name: <input type="text" name="dish_name"/>
                            Dish Description: <textarea name="dish_description">Enter dish description here...</textarea>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="vendor_id" value="1">
                            <input type="hidden" name="action" value="add">
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
                        <form id="addIngredient" action="ingredientservlet" method="post"> 
                            <!--Inputting form elements, already put for -->
                            Dish Name: <input type="text" name="dish_name" value="<%=dish.getDish_name()%>">
                            Dish Description: <textarea name="dish_description"><%=dish.getDish_description()%></textarea>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="dish_id" value="<%=dish.getDish_id()%>">
                            <input type="hidden" name="vendor_id" value="1">
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
                        Delete Dish
                    </div>

                    <div class="content">
                        <form id="addIngredient" action="ingredientservlet" method="post"> 
                            <!--Inserting delete danger message. -->

                            Are you sure you would like to delete the dish?

                            <!--Input hidden attributes-->
                            dish_name, dish_description,
                            <input type="hidden" name="dish_name" value="<%=dish.getDish_name()%>">
                            <input type="hidden" name="dish_description" value="<%=dish.getDish_description()%>">
                            <input type="hidden" name="dish_id" value="<%=dish.getDish_id()%>">
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
            </div>
        </div>
        <%}%>
        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>

