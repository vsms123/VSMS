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
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function () { // Prepare the document to ready all the dom functions before running this code
                $.post("orderservlet", function (responseText) {
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
                    <a class="section">Home</a>
                    <i class="right angle icon divider"></i>
                    <a class="section">Manage Menu</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Recipe Buider</div>
                </div>
                <h1>Order</h1>

                <form class="ui form" id="addOrder" action="orderservlet" method="post"> 
                    <!--Inputting form elements-->

                    <!--This table will send all the dishid info (textbox) with the dish_count as hidden parameter-->
                    <table id="orderListTable"></table>

                    <!--Input hidden attributes-->
                    <input type="hidden" name="vendor_id" value="1"/>
                    <br/>
                    <input type="submit" value="Add" class="ui big teal button" />
                </form>

            </div>
        </div>

        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
