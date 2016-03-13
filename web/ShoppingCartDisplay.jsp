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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
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
    </body>
</html>
