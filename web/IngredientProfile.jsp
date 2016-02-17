<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Controller.UtilityController"%>
<%@page import="Model.Ingredient"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Ingredient Profile</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code

            });
        </script>
    </head>
    <body class="background">


        <div class="transparency">

            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>


                <%
                    Vendor vendor = (Vendor) session.getAttribute("vendor");
                    if (vendor == null) {
                        vendor = UserController.retrieveVendorByID(1);
                    }
                    //this will get the ingredient name and supplier as the unique identifier of Ingredient
                    String supplierIdStr = request.getParameter("supplier_id");
                    String ingredientName = request.getParameter("ingredient_name");
                    Ingredient ingredient = IngredientController.getIngredient(supplierIdStr, ingredientName);
                %>

                <h2 class="ui header">
                    <img src="resource/pictures/carrot.png" alt="HTML5 Icon" style="width:45px;height:45px;">
                    
                    <div class="content">
                        Ingredient Profile
                        <div class="sub header">Check this ingredient</div>
                    </div>
                </h2>
                <h1 style="color:black"><%=ingredient.getName()%></h1>
                <table class="ui very padded large striped  table">
                    
                    <tr>
                        <th><h2>Description</h2></th>
                        <td><h3><%=ingredient.getDescription()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Supplier</h2></th>
                        <td><h3><%=UserController.retrieveSupplierByID(ingredient.getSupplier_id()).getSupplier_name()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Supply Unit</h2></th>
                        <td><h3><%=ingredient.getSupplyUnit()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Sub Category</h2></th>
                        <td><h3><%=ingredient.getSubcategory()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Offered Price</h2></th>
                        <td><h3><%=ingredient.getOfferedPrice()%></h3></td>
                    </tr>
                    
                </table>
                        <button class="ui large orange button"><a style="color:white" href="SupplierSearchProfile.jsp?supplier_id=<%=ingredient.getSupplier_id()%>" >To <%=UserController.retrieveSupplierByID(ingredient.getSupplier_id()).getSupplier_name()%>'s Page</a></button>
            </div>
        </div>
        <!--JAVASCRIPT-->
        <script>$("#form").validate();</script>
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>

