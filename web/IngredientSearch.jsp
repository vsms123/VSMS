<%@page import="Controller.TestController"%>
<%@page import="Model.Ingredient"%>
<%@page import="Model.Vendor"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Favourite Suppliers</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <%
            Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
            //in case current vendor does not exist
            if (currentVendor == null) {
                currentVendor = UserController.retrieveVendorByID(1);
            }

            //ID=session.getAttribute(vendor_id);
            ArrayList<Ingredient> ingredientList = TestController.getIngredientsSuppliedByFav(1);
            //ID=session.getAttribute(vendor_id);
            ArrayList<Supplier> favSupplierList = UserController.retrieveSupplierListByVendor(currentVendor.getVendor_id());
        %>

        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code

                //SEARCHING AND FILTERING
                //invoke get method in UserController with blank parameter given and blank response
                $.get("testservlet", {vendor_id: "1", supplier_id: "1", action: "search", word: $('#searchsupplier').val()}, function(responseText) {
                    $("#ingredientlist").html(responseText);
                });
                $("#searchsupplier").keyup(function() {
                    $.get("testservlet", {vendor_id: "1", supplier_id: "1", action: "search", word: $('#searchsupplier').val()}, function(responseText) {
                        $("#ingredientlist").html(responseText);
                    });
                });
                
               
                $('.create-favsupplier-button').click(function() {
                    //show modal button
                    $('#modaldiv').modal('show');
                });
            
            });
        </script>
        <!--CSS-->
        <style>
            .unstar {
                background:url('http://biscuithead.ie/images/logo.png') center no-repeat;

                position:absolute; 
                width:5%;
                height:5%;
                text-align:center; 
                vertical-align:middle;
                z-index: 9999;
            }
        </style>
        <!--for general CSS please refer to the main css. For others, please just append the link line below-->
        <link rel="stylesheet" type="text/css" href="css/main.css">

    </head>
    <body class="background">
        <div class="transparency">
            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>

                

                <!--MODAL DIV-->
                <button type="submit" name="submit" class="ui teal button create-favsupplier-button">Add Ingredient</button>
                <div id="modaldiv" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Add Ingredient
                    </div>
                    <div class="content">
                        <!--Inserting List of suppliers available. To star and unstar-->
                        <!--Create FavSupplier Filter with a search engine-->
                        Ingredient name : <input type="text" name="searchsupplier" id="searchsupplier" value=""/>

                        <table id="ingredientlist" name="ingredientlist">                                
                        </table>
                        <!--Todo: Supplier list favourite star and unstar-->

                        <!--Input hidden attributes-->
                        <input type="hidden" name="vendor_id" value="1">
                        <input type="hidden" name="action" value="delete">

                    </div>
                    <div class="actions">
                        <div class="ui positive right labeled icon button">
                            <a class="text-white" href="<?php echo site_url('home/order');?>">Back to Home</a>
                            <i class="checkmark icon"></i>
                        </div>
                    </div>
                </div>
                <!--Create many modals for each Fav supplier to be deleted-->
              
            </div>
        </div>
    </body>
</html>
