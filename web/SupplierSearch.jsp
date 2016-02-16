
<%@page import="Model.Vendor"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Supplier Search</title>
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
            ArrayList<Supplier> supplierList = UserController.retrieveSupplierList();
            //ID=session.getAttribute(vendor_id);
            ArrayList<Supplier> favSupplierList = UserController.retrieveSupplierListByVendor(currentVendor.getVendor_id());

            String ingredientName = request.getParameter("ingredient_name");
            if (ingredientName == null) {
                ingredientName = "";
            }
        %>

        <script>
            $(document).ready(function () { // Prepare the document to ready all the dom functions before running this code
                //SEARCHING AND FILTERING
                //invoke get method in UserController with blank parameter given and blank response with searchsupplierbyname
                $('.menu .item').tab();

                $.get("userservlet", {vendor_id: "1", supplier_id: "1", action: "searchsupplierbyname", word: $('#searchsupplierbyname').val()}, function (responseText) {
                    $("#supplierlistbyname").html(responseText);
                });
                $("#searchsupplierbyname").keyup(function () {
                    $.get("userservlet", {vendor_id: "1", supplier_id: "1", action: "searchsupplierbyname", word: $('#searchsupplierbyname').val()}, function (responseText) {
                        $("#supplierlistbyname").html(responseText);
                    });
                });

                //invoke get method in UserController with blank parameter given and blank response with searchsupplierbytype
                $.get("userservlet", {vendor_id: "1", supplier_id: "1", action: "searchsupplierbytype", word: $('#searchsupplierbytype').val()}, function (responseText) {
                    $("#supplierlistbytype").html(responseText);
                });
                $("#searchsupplierbytype").keyup(function () {
                    $.get("userservlet", {vendor_id: "1", supplier_id: "1", action: "searchsupplierbytype", word: $('#searchsupplierbytype').val()}, function (responseText) {
                        $("#supplierlistbytype").html(responseText);
                    });
                });

                //invoke get method in UserController with blank parameter given and blank response with searchsupplierbyingredient
                $.get("userservlet", {vendor_id: "1", supplier_id: "1", action: "searchingredient", word: $('#searchingredient').val()}, function (responseText) {
                    $("#ingredientlist").html(responseText);
                });
                $("#searchingredient").keyup(function () {
                    $.get("userservlet", {vendor_id: "1", supplier_id: "1", action: "searchingredient", word: $('#searchingredient').val()}, function (responseText) {
                        $("#ingredientlist").html(responseText);
                    });
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

                <h1>Supplier Search</h1>

                <div class="ui top attached tabular menu">
                    <a class="item active" data-tab="first">Supplier Name</a>
                    <a class="item" data-tab="second">Supplier Type</a>
                    <a class="item" data-tab="third">Ingredient</a>
                </div>

                <div class="ui bottom attached tab segment active" data-tab="first">

                    <h3>Supplier Name Search</h3>
                    Supplier name : <input type="text" name="searchsupplierbyname" id="searchsupplierbyname" value=""/>

                    <table id="supplierlistbyname">                                
                    </table>

                </div>


                <div class="ui bottom attached tab segment" data-tab="second">
                    <h3>Supplier Type Search</h3>                
                    Supplier type : <input type="text" name="searchsupplierbytype" id="searchsupplierbytype" value=""/>

                    <table id="supplierlistbytype">                                
                    </table>
                </div>

                <div class="ui bottom attached tab segment" data-tab="third">
                    <h3>Ingredient Name Search</h3>                

                    Ingredient Name : <input type="text" name="searchingredient" id="searchingredient" value="<%=ingredientName%>"/>


                    <table id="ingredientlist">                                
                    </table>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
