
<%@page import="Model.Vendor"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <%@ include file="protect.jsp" %>
        <title>Supplier Search</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <%            Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
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

                $.get("userservlet", {vendor_id: "<%=currentVendor.getVendor_id()%>", supplier_id: "1", action: "searchsupplierbyname", word: $('#searchsupplierbyname').val()}, function (responseText) {
                    $("#supplierlistbyname").html(responseText);
                });
                $("#searchsupplierbyname").keyup(function () {
                    $.get("userservlet", {vendor_id: "<%=currentVendor.getVendor_id()%>", supplier_id: "1", action: "searchsupplierbyname", word: $('#searchsupplierbyname').val()}, function (responseText) {
                        $("#supplierlistbyname").html(responseText);
                    });
                });

                //invoke get method in UserController with blank parameter given and blank response with searchsupplierbytype
                $.get("userservlet", {vendor_id: "<%=currentVendor.getVendor_id()%>", supplier_id: "1", action: "searchsupplierbytype", word: $('#searchsupplierbytype').val()}, function (responseText) {
                    $("#supplierlistbytype").html(responseText);
                });
                $("#searchsupplierbytype").keyup(function () {
                    $.get("userservlet", {vendor_id: "<%=currentVendor.getVendor_id()%>", supplier_id: "1", action: "searchsupplierbytype", word: $('#searchsupplierbytype').val()}, function (responseText) {
                        $("#supplierlistbytype").html(responseText);
                    });
                });

                //invoke get method in UserController with blank parameter given and blank response with searchsupplierbyingredient
                $.get("userservlet", {vendor_id: "<%=currentVendor.getVendor_id()%>", supplier_id: "1", action: "searchingredient", word: $('#searchingredient').val()}, function (responseText) {
                    $("#ingredientlist").html(responseText);
                });
                $("#searchingredient").keyup(function () {
                    $.get("userservlet", {vendor_id: "<%=currentVendor.getVendor_id()%>", supplier_id: "1", action: "searchingredient", word: $('#searchingredient').val()}, function (responseText) {
                        $("#ingredientlist").html(responseText);
                    });
                });

//Put in the active class at Ingredient Name Search if ingredient name is not empty
            <% if (!ingredientName.isEmpty()) {%>
                $("#supplier_name_div").removeClass("active");
                $("#supplier_name_tab").removeClass("active");
                $("#ingredient_name_div").addClass("active");
                $("#ingredient_name_tab").addClass("active");
            <%}%>

            });
        </script>
        <!--CSS-->

        <!--for general CSS please refer to the main css. For others, please just append the link line below-->
        <link rel="stylesheet" type="text/css" href="css/main.css">

    </head>
    <body class="background">
        <div class="transparency">
            <div class="ui segment" style="left:5%;width:90%">
                <%@include file="Navbar.jsp" %>

                 <h1 class="ui header">
                    <i class="search icon"></i>
                    <div class="content" >
                        Supplier Search
                        <div  style="color:black"  class="sub header">Find Suppliers/Ingredients</div>
                    </div>
                </h1>
                <br/>
<h2 style="color: black">Search by:</h2>
                <div class="ui top attached tabular menu">
                    <a class="item active" data-tab="first" id="supplier_name_tab"><h3>Supplier Name</h3></a>
                    <a class="item" data-tab="second" id="supplier_type_tab"><h3>Supplier Type</h3></a>
                    <a class="item" data-tab="third" id="ingredient_name_tab"><h3>Ingredients</h3></a>
                </div>

                <div class="ui bottom attached tab segment active" id="supplier_name_div" data-tab="first">


                    <div class="ui icon large input">


                        <input type="text" placeholder="Search..." name="searchsupplierbyname" id="searchsupplierbyname" value=""/>
                        <i class="circular search link icon"></i>

                    </div>
                    <div id="supplierlistbyname" class="ui middle aligned animated selection divided list">                                
                    </div>

                </div>


                <div class="ui bottom attached tab segment" id="supplier_type_div" data-tab="second">
                                    

                    <div class="ui large icon input">


                        <input type="text" placeholder="Search..." name="searchsupplierbytype" id="searchsupplierbytype" value=""/>
                        <i class="circular search link icon"></i>

                    </div>

                    <div id="supplierlistbytype" class="ui middle aligned animated selection divided list">                                
                    </div>
                </div>

                <div class="ui bottom attached tab segment" id="ingredient_name_div" data-tab="third">              
                    <div class="ui large icon input">
                        <input type="text" placeholder="Search..." name="searchingredient" id="searchingredient" value="<%=ingredientName%>"/>
                        <i class="circular search link icon"></i>

                    </div>

                    <div id="ingredientlist" class="ui middle aligned animated selection divided list">                                
                    </div>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
