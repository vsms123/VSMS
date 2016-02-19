<%-- 
    Document   : SupplierProfile
    Created on : Feb 19, 2016, 4:20:44 PM
    Author     : TC
--%>

<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page import="Model.Supplier"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@ include file="protect_supplier.jsp" %>
        <title>Supplier Profile</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function () { // Prepare the document to ready all the dom functions before running this code
                //To edit user account and password changes

                //Will go through the edit profile button
                $(".edit-profile-button").click(function () {
                    console.log("My name is edit-profile-button");
                    //show modal button
                    $('#editprofilemodal').modal('show');
                });
                //Will go through the edit password button
                $(".edit-password-button").click(function () {
                    console.log("My name is edit-password-button");
                    //show modal button
                    $('#editpasswordmodal').modal('show');
                });
            });
        </script>
    </head>
    <body class="background">


        <div class="transparency">

            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="SuppNavbar.jsp" %>


                <%
                    Supplier supp = (Supplier) session.getAttribute("currentSupplier");
                    Supplier currentSupplier = UserController.retrieveSupplierByID(supp.getSupplier_id());
                    if (currentSupplier == null) {
                        currentSupplier = UserController.retrieveSupplierByID(currentSupplier.getSupplier_id());
                    }
                %>
                <h2 class="ui header">
                    <i class="user icon"></i>
                    <div class="content">
                        View Profile
                        <div class="sub header">Manage Your Profile</div>
                    </div>
                </h2>
                <h1 style="color:black"><%=currentSupplier.getSupplier_name()%></h1>



                <table class="ui very padded large striped  table">
                    <tr>
                        <th><h2>Email</h2></th>
                    <td><h3><%=currentSupplier.getEmail()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Address</h2></th>
                    <td><h3><%=currentSupplier.getAddress()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Telephone Number</h2></th>
                    <td><h3><%="(" + currentSupplier.getArea_code() + ")" + currentSupplier.getTelephone_number()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Description</h2></th>
                    <td><h3><%=currentSupplier.getSupplier_description()%></h3></td>
                    </tr>
                </table>



                <button class="ui green large button edit-profile-button">Edit Profile</button>
                <button class="ui green large button edit-password-button">Edit Password</button>


                <!--Create a modal for editing the profile-->
                <div id="editprofilemodal" class="ui small modal">

                    <div class="header">
                        Edit Profile
                    </div>
                    <div class="content">
                        <form onsubmit="location.reload()" id="editProfile" class="editProfile ui form" action="userservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="email">Email:</label> 
                            <input id="email" value="<%=currentSupplier.getEmail()%>" type="text" name="email">

                            <label for="area_code">Area Code / Telephone Number:</label> 
                            <input id="area_code" value="<%=currentSupplier.getArea_code()%>" type="text" name="area_code">
                            <input id="telephone_number" value="<%=currentSupplier.getTelephone_number()%>" type="text" name="telephone_number">

                            <label for ="address">Address:</label> 
                            <textarea id="address" name="address"><%=currentSupplier.getAddress()%></textarea>

                            <label for ="supplier_description">Supplier Description:</label> 
                            <textarea id="supplier_description" name="supplier_description"><%=currentSupplier.getSupplier_description()%></textarea>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="supplier_id" value="<%=currentSupplier.getSupplier_id()%>">
                            <input type="hidden" name="action" value="editsupplierprofile">

                            <input type="submit" value="Edit Profile" class="ui teal button" />
                        </form>
                    </div>
                    <div class="actions">

                        <button class="ui inverted deny orange button">Cancel</button>

                    </div>

                </div>

                <!--Create a modal for editing the password-->
                <div id="editpasswordmodal" class="ui small modal">

                    <div class="header">
                        Edit Password
                    </div>
                    <div class="content">
                        <form onsubmit="location.reload()" id="editPassword" class="editPassword ui form" action="userservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="old_password">Old Password:</label> 
                            <input id="old_password" type="text" name="old_password">

                            <label for="new_password">New Password:</label> 
                            <input id="new_password" type="text" name="new_password">
                            <label for="new2_password">Repeat Password:</label> 
                            <input id="new2_password" type="text" name="new2_password">

                            <!--Input hidden attributes-->
                            <input type="hidden" name="supplier_id" value="<%=currentSupplier.getSupplier_id()%>">
                            <input type="hidden" name="action" value="editsupplierpassword">

                            <input type="submit" value="Edit password" class="ui teal button" /> 
                        </form>
                    </div>
                    <div class="actions">

                        <button class="ui inverted deny orange button">Cancel</button>

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

