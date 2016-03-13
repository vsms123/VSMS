<%-- 
    Document   : TestButton
    Created on : Feb 27, 2016, 11:46:34 AM
    Author     : David
--%>

<%@page import="Model.Dish"%>
<%@page import="Controller.IngredientController"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.IngredientDAO"%>
<%@page import="Model.Ingredient"%>
<%@page import="Model.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script>
      $(function () {

        $('form').on('submit', function (e) {

          e.preventDefault();

          $.ajax({
            type: 'get',
            url: 'OrderByIngredientServlet',
            data: $(this).serialize(),
            success: function () {
              alert('form was submitted');
            }
          });

        });

      });
    </script>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            int cartID=(Integer)session.getAttribute("CartId");
            Dish cart=(Dish)IngredientDAO.getIngredientTemplateByID(cartID);
            Ingredient ingredient=IngredientDAO.getIngredient("1", "Coffee Beans");
            IngredientDAO.updateIngredientTemplate(cart);
        %>
        <!--adds an ingredient to cart-->
        Select number of coffee beans to add to shopping cart
        <form action="OrderByIngredientServlet" method="get">
            Quantity<input type="text" value="0" name="quantity">
            <input type="hidden" name="ingredientname" value="Coffee Beans">
            <input type="hidden" name="supplierId" value="1">
            <input type="hidden" name="CartId" value="<%=cartID%>">
            <input type="hidden" name="action" value="add">
            <input type="submit">
        </form>
            <!--End of adding-->
        <!--Prints out the contents of a shopping cart named cart-->
        Contents of cart
        <table>
            <tr><td>Ingredient</td><td>Quantity</td><td>Units</td></tr>
            <%
                HashMap<Ingredient,ArrayList<String>> map=cart.getIngredientQuantity();
                Set<Ingredient> ingredientSet=map.keySet();
                Iterator iter=ingredientSet.iterator();
                while(iter.hasNext()){
                    Ingredient ing=(Ingredient)iter.next();
                    ArrayList<String> list=map.get(ing);
                %>
                <tr><td><%=ing.getName()%></td><td><%=list.get(0)%></td><td><%=list.get(1)%></td></tr>
                <%
                }
            %>
            
        </table>
        <!--End printing of shopping cart contents-->

        <!--Sends shopping cart to orderbreakdown servlet to convert into order-->
        Send cart to orderbreakdown
        <%=cart.getDish_id()%>
        <form action="OrderBreakdown.jsp" method="POST">
            <input type="hidden" value="1" name="dish<%=cart.getDish_id()%>">
            <input type="hidden" name="vendor_id" value="1"/>
            <input type="submit" value="Submit"> 
        </form>
        <!--End order sending-->
        <!--Saves shopping cart to template-->
        Save shopping cart to template
        <form action="OrderByIngredientServlet" method="get">
            Template name<input type="text" value="" name="name" required>
            Template description<input type="text" value="" name="description" required>
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="CartId" value="<%=cartID%>">
            <input type="submit" value="save">
        </form>
        <!--End of saving shopping card-->
        <!--Loads a list of templates while excluding the current shopping cart-->
        Templates in database
        <%
            ArrayList<Dish> dishList=IngredientDAO.getIngredientTemplates("1");
            for(Dish dish:dishList){
                if(dish.getDish_id()!=cartID){
            
        %>
        <%=dish.getDish_name()%><br>
        <%=dish.getDish_description()%><br>
        
        
        <%      }
            }%>
        
        <!--End loading list of templates-->
        <!--sets a selected template as the one-click-order-->
        Select one-click order template
        <form action="OrderByIngredientServlet" method="get">
            CartID<input type="text" name="CartId">
            <input type="hidden" name="action" value="select">
            <input type="submit">
        </form>
        <!--end-->
        Delete shopping cart stored in session
        <form action="OrderByIngredientServlet" method="get">
            <input type="hidden" name="action" value="invalidate">
            <input type="hidden" name="CartId" value="<%=cartID%>">
            <input type="submit" value="delete">
        </form>
    </body>
</html>
