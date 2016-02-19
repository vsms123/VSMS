<%-- 
    Document   : RecipeBuilder
    Created on : Jan 18, 2016, 12:59:09 PM
    Author     : Benjamin
--%>

<%@page import="Controller.UtilityController"%>
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
        <title>Order</title>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
            
            ArrayList<Dish> dishList = IngredientController.getDish(UtilityController.convertIntToString(currentVendor.getVendor_id()));
        %>
        <script>
            $(document).ready(function() { // Prepare the document to ready all the dom functions before running this code

            }
        </script>

        <!--CSS-->
        <!-- Import CDN for semantic UI -->    

    </head>
    <body class="background">


        <div class="transparency">


            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>

                <h1 style="color: black">Create Template</h1>


                <!--Inputting form elements-->
                <br/>
                <form action="TemplateServlet" method="get">
                    <h2 style="color:black">Name of Template:</h2>
                    <div style="padding-right:40%" class="ui fluid input">
                        <input type="text" placeholder="Name your template.." name="template"/>&nbsp;
                    </div>
                    <!--This table will send all the dishid info (textbox) with the dish_count as hidden parameter-->

                    <table id="orderListTable" class="ui padded large striped  table">
                        <tr><th><h2>Dish Name</h2></th>
                            <th><h2>Quantity</h2></th>
                        </tr>
                        <%
                            for (Dish dish : dishList) {%>
                        <tr>
                            <td><h3><label for= "dish<%=dish.getDish_id()%>"> <%=dish.getDish_name()%></label></h3></td>
                            <td>
                                <div class="ui input">
                        <input type="number" value=1 placeholder="Name your template.." id="ordervalue<%=dish.getDish_id()%>" name="dish<%=dish.getDish_id()%>"/>&nbsp;
                    </div>
                                
                        </tr>
                        <%}%>
                    </table>
                    <!--Input hidden attributes-->
                    <input type="hidden" name="vendor_id" value="<%=currentVendor.getVendor_id()%>"/>
                    <br/>

                    <button type="submit" class="ui green large button" name="submit" id="submit"/><i class="checkmark icon"></i>Check Order Breakdown </button>
                </form>
            </div>
        </div>

        <!--JAVASCRIPT-->
        <!--for general Javascript please refer to the main js. For others, please just html the script line below-->
        <script src="js/main.js" type="text/javascript"></script>
    </body>
</html>
