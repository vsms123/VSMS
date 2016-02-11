<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Vendor Profile</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code
                //To edit user account and password changes

                //Will go through the edit profile button
                $(".edit-profile-button").click(function() {
                    console.log("My name is edit-profile-button");
                    //show modal button
                    $('#editprofilemodal').modal('show');
                });
                //Will go through the edit password button
                $(".edit-password-button").click(function() {
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
                %>
                <h1><%=vendor.getVendor_name()%></h1>
                <table>
                    <tr>
                        <th>Email</th>
                        <td><%=vendor.getEmail()%></td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td><%=vendor.getAddress()%></td>
                    </tr>
                    <tr>
                        <th>Telephone Number</th>
                        <td><%="(" + vendor.getArea_code() + ")" + vendor.getTelephone_number()%></td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td><%=vendor.getVendor_description()%></td>
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
                        <form id="editProfile" class="editProfile ui form" action="userservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="email">Email:</label> 
                            <input id="email" value="<%=vendor.getEmail()%>" type="text" name="email">

                            <label for="area_code">Area Code / Telephone Number:</label> 
                            <input id="area_code" value="<%=vendor.getArea_code()%>" type="text" name="area_code">
                            <input id="telephone_number" value="<%=vendor.getTelephone_number()%>" type="text" name="telephone_number">

                            <label for ="address">Address:</label> 
                            <textarea id="address" name="address"><%=vendor.getAddress()%></textarea>

                            <label for ="vendor_description">Vendor Description:</label> 
                            <textarea id="vendor_description" name="vendor_description"><%=vendor.getVendor_description()%></textarea>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="vendor_id" value="1">
                            <input type="hidden" name="action" value="editprofile">

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
                        <form id="editPassword" class="editPassword ui form" action="userservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="old_password">Old Password:</label> 
                            <input id="old_password" type="text" name="old_password">

                            <label for="new_password">New Password:</label> 
                            <input id="new_password" type="text" name="new_password">
                            <label for="new2_password">Repeat Password:</label> 
                            <input id="new2_password" type="text" name="new2_password">

                            <!--Input hidden attributes-->
                            <input type="hidden" name="vendor_id" value="1">
                            <input type="hidden" name="action" value="editpassword">

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

