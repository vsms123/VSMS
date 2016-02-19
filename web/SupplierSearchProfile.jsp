<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Model.Ingredient"%>
<%@page import="Controller.UtilityController"%>
<%@page import="Model.Supplier"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@ include file="protect.jsp" %>

        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function () { // Prepare the document to ready all the dom functions before running this code
                //To edit user account and password changes

                //Will go through the edit profile button
                $(".favorite-supplier").click(function () {
                    //show modal button
                    $('#favoritesupppliermodal').modal('show');
                });
                //Will go through the edit password button
                $(".unfavorite-supplier").click(function () {
                    //show modal button
                    $('#unfavoritesuppliermodal').modal('show');
                });

                $('.menu .item').tab();

                $('.test.ingredients').popup({
                    position: 'top left'
                });
            });
        </script>
        <title>Supplier Search Profile</title>
    </head>
    <body class="background">


        <div class="transparency">

            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>

                <%                    Vendor vendor = (Vendor) session.getAttribute("currentVendor");
                    if (vendor == null) {
                        vendor = UserController.retrieveVendorByID(1);
                    }
                    int vendor_id = vendor.getVendor_id();
                    String supplier_idStr = request.getParameter("supplier_id");
                    int supplier_id = UtilityController.convertStringtoInt(supplier_idStr);
                    Supplier supplier = UserController.retrieveSupplierByID(supplier_id);
                %>
                <h2 class="ui header">
                    <i class="settings icon"></i>
                    <div class="content">
                        Supplier Profile
                        <div class="sub header">View Supplier Profile</div>
                    </div>
                </h2>




                <h1 style="color:black"><%=supplier.getSupplier_name()%></h1>


                <div class="ui top attached tabular menu">
                    <a class="item active" data-tab="supplierDescription" id="supplier_name_tab">Supplier Details</a>
                    <a class="item" data-tab="ingredients" id="supplier_type_tab">Supplied Ingredients</a>
                </div>
                <div class="ui bottom attached tab segment active" id="supplier_name_div" data-tab="supplierDescription">
                    <table class="ui very padded large striped  table">
                        <tr>
                            <th><h2>Description</h2></th>
                            <td><h3><%=supplier.getSupplier_description()%></h3></td>
                        </tr>
                        <tr>
                            <th><h2>Email</h2></th>
                            <td><h3><%=supplier.getEmail()%></h3></td>
                        </tr>
                        <tr>
                            <th><h2>Address</h2></th>
                            <td><h3><%=supplier.getAddress()%></h3></td>
                        </tr>
                        <tr>
                            <th><h2>Telephone Number</h2></th>
                            <td><h3><%="(" + supplier.getArea_code() + ")" + supplier.getTelephone_number()%></h3></td>
                        </tr>

                    </table>
                    <%
                        ArrayList<Supplier> favSupplierList = UserController.retrieveSupplierListByVendor(vendor.getVendor_id());
                        if (favSupplierList.contains(supplier)) {
                    %>
                    <button class="ui red large button unfavorite-supplier">Unfavorite</button>
                    <%
                    } else {
                    %><button class="ui green large button favorite-supplier">Make as Favorite</button>
                    <%
                        }
                    %>
                </div>

                <div class="ui bottom attached tab segment" id="supplier_name_div" data-tab="ingredients">
                    <!--Table to show the ingredient list-->
                    <table class="ui padded large striped  table">
                        <tr>
                            <th><h2>Ingredients Supplied</h2></th>
                        </tr>
                        <%
                            ArrayList<Ingredient> ingredientList = IngredientController.getIngredientBySupplier(supplier_id);
                            for (Ingredient ingredient : ingredientList) {
                        %>
                        <tr>

                            <td>
                                <div class="item test ingredients" data-content="Click to view ingredient details"  data-variation="inverted">
                                    <h3>    
                                        <a href="IngredientProfile.jsp?ingredient_name=<%=ingredient.getName()%>&supplier_id=<%=supplier_id%>"><%=ingredient.getName()%></a>
                                    </h3>
                                </div>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                    <!--Create a modal for favorite the supplier-->
                </div>





                <div id="favoritesupppliermodal" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Favorite This Supplier
                    </div>

                    <div class="content">
                        <form class="ui form" id="deleteFavsupplier" action="userservlet" method="get"> 
                            <!--Inserting delete danger message. -->

                            Are you sure you would like to favorite this supplier?

                            <!--Input hidden attributes-->
                            <input type="hidden" name="supplier_id" value="<%=supplier.getSupplier_id()%>">
                            <input type="hidden" name="vendor_id" value="<%=vendor_id%>">
                            <input type="hidden" name="action" value="create">

                            <input type="submit" value="Favorite this Supplier" class="ui teal button" /> 
                        </form>
                    </div>
                    <div class="actions">
                        <div class="ui positive right labeled icon button">
                            <a class="text-white" href="<?php echo site_url('home/order');?>">Back to Home</a>
                            <i class="checkmark icon"></i>
                        </div>
                    </div>
                </div>

                <!--Create a modal for unfavorite the supplier-->
                <div id="unfavoritesuppliermodal" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Unfavorite This Supplier
                    </div>

                    <div class="content">
                        <form class="ui form" id="deleteFavsupplier" action="userservlet" method="get"> 
                            <!--Inserting delete danger message. -->

                            Are you sure you would like to unfavorite this supplier?

                            <!--Input hidden attributes-->
                            <input type="hidden" name="supplier_id" value="<%=supplier.getSupplier_id()%>">
                            <input type="hidden" name="vendor_id" value="<%=vendor_id%>">
                            <input type="hidden" name="action" value="delete">

                            <input type="submit" value="Unfavorite This Supplier" class="ui red button" /> 
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
        <script>$("#form").validate();</script>
        <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>

