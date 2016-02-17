
<%@page import="Model.Vendor"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Favorite Suppliers</title>
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
        %>

        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
            <%
                for (Supplier supplier : favSupplierList) {
                    int supplier_id = supplier.getSupplier_id();
            %>

                //CREATE DELETE CLICK OF BUTTONS
                $(".delete-favsupplier-button<%=supplier_id%>").click(function() {

                    console.log("My name is delete-favsupplier-button<%=supplier_id%>");
                    //show modal button
                    $('#deletemodaldiv<%=supplier_id%>').modal('show');
                });
            <%}%>
            
            $('.test.supplier').popup({
                    position: 'top left'
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

                <h1>Your Favorite Suppliers</h1>
                
                
                
                        
                    
                
                <div class="ui middle aligned animated selection divided list">
                    <%for (Supplier supplier : favSupplierList) {%>

                    <div class="item test supplier" data-content="Click to go to Supplier's page"  data-variation="inverted">
                        <div class="extra right floated content">
                            <button class="ui red inverted button delete-favsupplier-button<%=supplier.getSupplier_id()%>"> <i class="remove icon"></i>Remove from Favorites</button>
                        </div>
                        <a href="SupplierSearchProfile.jsp?supplier_id=<%=supplier.getSupplier_id()%>" >
                            <div class="content">
                                <h2><%=supplier.getSupplier_name()%></h2>
                                
                                <td></td>
                            </div>
                            <div class='description' style='color:black'>
                                <%=supplier.getSupplier_description()%> <br/>
                                <%=supplier.getEmail()%>
                            </div>
                        </a>
                        
                        
                    </div>
                            
                    <%
                        }
                    %>
                </div>
                <br/>

                <!--Create a button to refer to SupplierSearch-->
                <button class='ui large orange button'><a href="SupplierSearch.jsp" style='hover:white; color:white'>Search for Suppliers</a></button>

                <!--Create many modals for each Fav supplier to be deleted-->
                <% for (Supplier supplier : favSupplierList) {
                %>

                <div id="deletemodaldiv<%=supplier.getSupplier_id()%>" class="ui small modal">
                    <i class="close icon"></i>
                    <div class="header">
                        Delete Favorite Supplier
                    </div>

                    <div class="content">
                        <form class="ui form" id="deleteFavsupplier" action="userservlet" method="get"> 
                            <!--Inserting delete danger message. -->

                            Are you sure you would like to unfavorite this supplier?

                            <!--Input hidden attributes-->
                            <input type="hidden" name="supplier_id" value="<%=supplier.getSupplier_id()%>">
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
                <%}%>
            </div>
        </div>
    </body>
</html>
