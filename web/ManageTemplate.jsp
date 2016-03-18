<%-- 
    Document   : ManageTemplate
    Created on : Mar 13, 2016, 5:10:51 PM
    Author     : David
--%>

<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page import="Model.Ingredient"%>
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
         <div id="pc pusher" class="background">


            <div class="transparency">


                <div  class="ui segment" style="left:5%;width:90%">

                    <%@ include file="Navbar.jsp" %>
        <%
                        Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
            if (currentVendor == null) {
                currentVendor = UserController.retrieveVendorByID(1);
            }
                        int cartID = (Integer) IngredientDAO.getIngredientTemplateID(currentVendor.getVendor_id()+"") - 1;
                        Dish cart = (Dish) IngredientDAO.getIngredientTemplateByID(cartID);
                        IngredientDAO.updateIngredientTemplate(cart);

                    %>
        Templates in database
                    <table border="1">
                        <%
                            ArrayList<Dish> dishList = IngredientDAO.getIngredientTemplates("1");
                            for (Dish dish : dishList) {
                                if (dish.getDish_id() != cartID) {

                        %>
                        <tr>
                            <td><%=dish.getDish_name()%><br></td>
                            <td><%=dish.getDish_description()%><br></td>




                            <td>
                                <!--End loading list of templates-->
                                <!--sets a selected template as the one-click-order-->
                                <%if(IngredientDAO.isOneClickOrder(dish.getDish_id())){%>
                                selected
                                <%}else{%>
                                <form action="OrderByIngredientServlet" method="get">
                                    <input type="hidden" name="CartId" value="<%=dish.getDish_id()%>">
                                    <input type="hidden" name="action" value="select">
                                    <input type="submit" value="select">
                                </form>
                                <%}%>
                            </td>
                        </tr>
                        <%      }
                        }%>
                    </table>
                    
                </div>
            </div>
         </div>
                    
    </body>
</html>
