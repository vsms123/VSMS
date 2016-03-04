

<%@page import="Controller.IngredientController"%>
<%@page import="Model.Dish"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@ include file="protect.jsp" %>
        <title>Recipe Builder</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <!--CSS-->
        <!— Import CDN for semantic UI —>    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/main.css">

        <script>
            $(document).ready(function () {
                $("#testing").click(function () {
                    $('.vertical.menu').sidebar('setting', 'transition', 'overlay')
                            .sidebar('toggle');
                    
                    $( "body" ).removeClass( "pushable" );
                });

            });
        </script>
    </head>
    <body>

        <%           ArrayList<Dish> dishList = IngredientController.getDish("1");

        %>

        <div class="ui pusher middle aligned animated selection divided list">
            <%for (Dish dish : dishList) {%>


            <div class="item test dish" data-content="Click to view/edit dish"  data-variation="inverted">
                <a href="RecipeBuilder.jsp?dish_id=<%=dish.getDish_id()%>" >
                    <div class="content">
                        <h2><%=dish.getDish_name()%></h2>
                    </div>
                    <div>
                        <%=dish.getDish_description()%>
                    </div>
                </a>
            </div>




            <%}%>
        </div>
        
        
        
        <div class="content">
            asfaf
        </div>




        <button id="testing">asdoabsdas</button>
        Testin


    </body>
    <div class="ui sidebar inverted vertical menu">
        <a class="item">
            1
        </a>
        <a class="item">
            2
        </a>
        <a class="item">
            3
        </a>
    </div>
</html>