<%@page import="Controller.OrderController"%>
<%@page import="Controller.ConnectionManager"%>
<%@page import="Model.Order"%>
<%@page import="java.util.ArrayList"%>

<html>
    <head>
        <meta charset="utf-8" />
        <title>Order History</title>

        <!--CSS-->
        <!-- Import CDN for semantic UI -->    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <!--for general CSS please refer to the main css. For others, please just append the link line below-->
        <link rel="stylesheet" type="text/css" href="css/main.css">

        <!-- JSP Controller/ Variables Initiation -->
        <%
            ArrayList<Order> orderList = OrderController.retrieveOrderList(1);
        %>

        <script>
            $(document).ready(function () {
                $('.secondary.menu .item').tab();
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
                    <a href="" class="section">Order</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Order History</div>
                </div>
                <h1 style="color: black">Order History List</h1>


                <div class="ui pointing secondary menu">
                    <a class="item active" data-tab="first">Pending Orders</a>
                    <a class="item" data-tab="second">Completed Orders</a>
                    <a class="item" data-tab="third">Rejected Orders</a>
                </div>
                <div class="ui tab segment active" data-tab="first">
                    <ul>
                    <%for (Order order : orderList) {%>

                    <%
                        if (order.getStatus().equals("pending")) {
                    %><li><%=order%></li>  <%
                        }
                        %>
                        <%}%>
                </ul>
                    
                </div>
                <div class="ui tab segment" data-tab="second">
                    <ul>
                    <%for (Order order : orderList) {%>

                    <%
                        if (order.getStatus().equals("approved")) {
                    %><li><%=order%></li>  <%
                        }
                        %>
                        <%}%>
                    </ul>
                </div>
                <div class="ui tab segment" data-tab="third">
                    <ul>
                    <%for (Order order : orderList) {%>

                    <%
                        if (order.getStatus().equals("rejected")) {
                    %><li><%=order%></li>  <%
                        }
                        %>
                        <%}%>
                    </ul>
                </div>



                

                <!--JAVASCRIPT-->
                <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
                <script src="js/main.js" type="text/javascript"></script>

            </div>
        </div>
    </body>
</html>
