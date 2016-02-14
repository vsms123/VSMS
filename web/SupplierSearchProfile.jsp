<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

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
        <title>Supplier Search Profile</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
                //To edit user account and password changes

                //Will go through the edit profile button
                $(".favorite-supplier").click(function() {
                    //show modal button
                    $('#favoritesupppliermodal').modal('show');
                });
                //Will go through the edit password button
                $(".unfavorite-supplier").click(function() {
                    //show modal button
                    $('#unfavoritesuppliermodal').modal('show');
                });
            });
        </script>
    </head>
    <body class="background">


        <div class="transparency">

            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                <div class="ui breadcrumb" >
                    <a href="Home.jsp" class="section">Home</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Vendor Profile</div>
                </div>

                <%
                    Vendor vendor = (Vendor) session.getAttribute("vendor");
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
                        <%=supplier.getSupplier_name()%>
                        <div class="sub header">View Supplier Profile</div>
                    </div>
                </h2>
                <h1><%=supplier.getSupplier_name()%></h1>
                <table>
                    <tr>
                        <th>Email</th>
                        <td><%=supplier.getEmail()%></td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td><%=supplier.getAddress()%></td>
                    </tr>
                    <tr>
                        <th>Telephone Number</th>
                        <td><%="(" + supplier.getArea_code() + ")" + supplier.getTelephone_number()%></td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td><%=supplier.getSupplier_description()%></td>
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



                <!--Create a modal for favorite the supplier-->
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

                            Are you sure you would like to unfavourite this supplier?

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

