<%-- 
    Document   : ShoppingCartDisplay
    Created on : Mar 13, 2016, 4:17:38 PM
    Author     : David
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="Model.Ingredient"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Dish"%>
<%@page import="DAO.IngredientDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/formvalidation.js" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        

        <link rel="stylesheet" href="css/main.css">
        <title>My Shopping Cart</title>

    </head>
    <body class="background">


        <div class="transparency">


            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
                Contents of cart
                <table border="1">
                    <tr><td>Ingredient</td><td>Quantity</td><td>Units</td></tr>
                    <%
                        int cartID = (Integer) IngredientDAO.getIngredientTemplateID("1") - 1;
                        Dish cart = (Dish) IngredientDAO.getIngredientTemplateByID(cartID);
                        IngredientDAO.updateIngredientTemplate(cart);
                        HashMap<Ingredient, ArrayList<String>> map = cart.getIngredientQuantity();
                        Set<Ingredient> ingredientSet = map.keySet();
                        Iterator iter = ingredientSet.iterator();
                        while (iter.hasNext()) {
                            Ingredient ing = (Ingredient) iter.next();
                            ArrayList<String> list = map.get(ing);
                    %>
                    <tr><td><%=ing.getName()%></td><td><%=list.get(0)%></td><td><%=list.get(1)%></td></tr>
                    <%
                        }
                    %>

                </table>

                <br>
                <br>
                Send cart to orderbreakdown
                <form action="OrderBreakdown.jsp" method="POST">
                    <input type="hidden" value="1" name="dish<%=cart.getDish_id()%>">
                    <input type="hidden" name="vendor_id" value="1">
                    <input type="hidden" name="cart" value="yes">
                    <input type="submit" value="Submit"> 
                </form>

                <br>
                <br>
                Save current shopping cart to template
                <table border="1"><tr>
                    <form action="OrderByIngredientServlet" method="get">
                        <td>Template name<input type="text" value="" name="name" required></td>
                        <td>Template description<input type="text" value="" name="description" required></td>
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="CartId" value="<%=cartID%>">
                        <td><input type="submit" value="save"></td>
                    </form>
                    </tr>
                </table>
            </div>
        </div>

    </body>
</html>
