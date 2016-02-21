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
        <%@ include file="protect.jsp" %>
        <title>Vendor Profile</title>
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
                <%@ include file="Navbar.jsp" %>


                <%                    Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
                    if (currentVendor == null) {
                        currentVendor = UserController.retrieveVendorByID(1);
                    }
                %>
                <h1 class="ui header">
                    <i class="user icon"></i>
                    <div class="content">
                        View Profile
                        <div  style="color:black"  class="sub header">Managing Your Profile</div>
                    </div>
                </h1>
                <h1 style="color:black"><%=currentVendor.getVendor_name()%></h1>



                <table class="ui very padded large striped  table">
                    <tr>
                        <th><h2>Email</h2></th>
                    <td><h3><%=currentVendor.getEmail()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Address</h2></th>
                    <td><h3><%=currentVendor.getAddress()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Telephone Number</h2></th>
                    <td><h3><%="(" + currentVendor.getArea_code() + ")" + currentVendor.getTelephone_number()%></h3></td>
                    </tr>
                    <tr>
                        <th><h2>Description</h2></th>
                    <td><h3><%=currentVendor.getVendor_description()%></h3></td>
                    </tr>
                </table>



                <button class="ui green large button edit-profile-button">Edit Profile</button>
                <button class="ui green large button edit-password-button">Change Password</button>


                <!--Create a modal for editing the profile-->
                <div id="editprofilemodal" class="ui small modal">

                    <div class="header">
                        <h2>Edit Profile</h2>
                    </div>
                    <div class="content">
                        <form id="editProfile" class="editProfile ui form" action="userservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="email"><h3>Email:</h3></label>
                            <input id="email" value="<%=currentVendor.getEmail()%>" type="text" name="email"><br/>
                            <br/>
                            <label for="area_code"><h3>Area Code / Telephone Number:</h3></label> 
                            <div class="ui grid">
                                <div class="three wide column">
                                    <input id="area_code" value="<%=currentVendor.getArea_code()%>" type="text" name="area_code">
                                </div>
                                <div class="thirteen wide column">
                                    <input id="telephone_number" value="<%=currentVendor.getTelephone_number()%>" type="text" name="telephone_number">
                                </div>
                            </div><br/>

                            <label for ="address"><h3>Address:</h3></label> 
                            <textarea id="address" name="address"><%=currentVendor.getAddress()%></textarea>
                            <br/><br/>
                            <label for ="vendor_description"><h3>Description:</h3></label> 
                            <textarea id="vendor_description" name="vendor_description"><%=currentVendor.getVendor_description()%></textarea>
                            <br/>
                            <!--Input hidden attributes-->
                            <input type="hidden" name="vendor_id" value="<%=currentVendor.getVendor_id()%>">
                            <input type="hidden" name="action" value="editprofile">


                            </div>
                            <div class="actions">
                                <input type="submit" value="Save Changes" class="ui inverted green button" />
                        </form>
                        <button class="ui inverted deny orange button">Cancel</button>

                    </div>

                </div>

                <!--Create a modal for editing the password-->
                <div id="editpasswordmodal" class="ui small modal">

                    <div class="header">
                        <h2>Edit Password</h2> 
                    </div>
                    <div class="content">
                        <form id="editPassword" class="editPassword ui form" action="userservlet" method="post"> 
                            <!--Inputting form elements-->
                            <label for="old_password"><h3>Old Password:</h3></label> 
                            <input id="old_password" type="text" name="old_password"><br/><br/>

                            <label for="new_password"><h3>New Password:</h3></label> 
                            <input id="new_password" type="text" name="new_password"><br/><br/>

                            <label for="new2_password"><h3>Re-enter new Password:</h3></label> 
                            <input id="new2_password" type="text" name="new2_password"><br/><br/>

                            <!--Input hidden attributes-->
                            <input type="hidden" name="vendor_id" value="<%=currentVendor.getVendor_id()%>">
                            <input type="hidden" name="action" value="editpassword">


                            </div>
                            <div class="actions">
                                <input type="submit" value="Confirm password" class="ui inverted green button" /> 
                        </form>
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

