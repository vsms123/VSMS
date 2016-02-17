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
                    <i class="settings icon"></i>
                    <div class="content">
                        Ingredient Profile
                        <div class="sub header">Check this ingredient</div>
                    </div>
                </h2>
                <h1><%=ingredient.getName()%></h1>
                <table>
                    <tr>
                        <th>Supplier</th>
                        <td><%=UserController.retrieveSupplierByID(ingredient.getSupplier_id()).getSupplier_name()%></td>
                    </tr>
                    <tr>
                        <th>Supply Unit</th>
                        <td><%=ingredient.getSupplyUnit()%></td>
                    </tr>
                    <tr>
                        <th>Sub Category</th>
                        <td><%=ingredient.getSubcategory()%></td>
                    </tr>
                    <tr>
                        <th>Offered Price</th>
                        <td><%=ingredient.getOfferedPrice()%></td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td><%=ingredient.getDescription()%></td>
                    </tr>
                </table>
                <button><a href="SupplierSearchProfile.jsp?supplier_id=<%=ingredient.getSupplier_id()%>">Go to your Supplier here</a></button>
            </div>
        </div>
        <!--JAVASCRIPT-->
        <script>$("#form").validate();</script>
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>

