<%-- 
    Document   : index
    Created on : Jan 13, 2016, 5:41:13 PM
    Author     : TC
--%>

<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="Model.Ingredient"%>
<%@page import="Model.Supplier"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="javascript.js"></script>
        <link rel="stylesheet" type="text/css" href="stylesheet.css">
        <title>Supplier Search</title>
    </head>
    <body onload="init()">

        <h1>Supplier Search</h1>
        <p>Enter the name or category of suppliers to search for</p>
        <% session.setAttribute("isSupplier","false");
        //Create a variable to store dish object from recipe builder
        //Dish dish=(Dish)request.getAttribute("dish");
        //create variable to store test dish
        Dish dish=IngredientController.getDishByID(2);
        //End creation of variables
        
        %>
        <form name="autofillform" action="autocomplete"><table border="0" cellpadding="5">
                
                <tbody>
                    <tr>
                        <td><strong>Supplier Name:</strong></td>
                        <td>
                            <input type="text"
                                   size="40"
                                   id="complete-field"
                                   onkeyup="doCompletion();">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="searchType" id ="r1" value="true"> Supplier<br>
                            <input type="radio" name="searchType" id ="r2" value="false"> Ingredient<br>
                        </td>
                    </tr>
                    <tr>
                        <td id="auto-row" colspan="2">
                            <table id="complete-table" class="popupBox"></table>
                        </td>
                    </tr>
                </tbody>
            </table>

        </form>
        <!--Supplier info loaded here-->
        <%
            Supplier sup=(Supplier)request.getAttribute("supplier");
            if(sup!=null){
        %>
        <table>
            <tr>
                <th colspan="2">Supplier Information</th>
            </tr>
            <tr>
                <td>Supplier Name: </td>
                <td><%=sup.getSupplier_name()%></td>
            </tr>
            <tr>
                <td>Type: </td>
                <td><%=sup.getSupplier_type()%></td>
            </tr>
            <tr>
                <td>ID: </td>
                <td><%=sup.getSupplier_id()%></td>
            </tr>
            <tr>
                <td>Address: </td>
                <td><%=sup.getAddress()%></td>
            </tr>      
        </table>
        <%};%>
        <!--End loading of supplier info-->
        
        <!--Ingredient info loaded here-->
        <%
            Ingredient ing=(Ingredient)request.getAttribute("ingredient");
            if(ing!=null){
            dish.addIngredient(ing,"20","kg");
            
        %>
        <table>
            <tr>
                <th colspan="2">Dish Information</th>
            </tr>
            <tr>
                <td>Dish Name: </td>
                <td><%=dish.getDish_name()%></td>
                <td><%=dish.getDish_description()%></td>
                <td><%=dish.toString()%></td>
            </tr>
            
        </table>
        <%};%>
        <!--End loading of ingredient info-->
        
    </body>
</html>