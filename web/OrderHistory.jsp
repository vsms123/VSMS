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
        <script>
            $(document).ready(function () {
                $('.secondary.menu .item').tab();

                $('.test.dish').popup({
                    position: 'top left'
                });
            });
        </script>
        <style>
            a:link {
                color: black;
            }

            /* visited link */
            a:visited {
                color: Black;
            }

            /* mouse over link */
            a:hover {
                color: hotpink;
            }

            /* selected link */
            a:active {
                color: black;
            }
        </style>

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

                <%
                    ArrayList<Order> pendingOrders = new ArrayList<Order>();
                    ArrayList<Order> completedOrders = new ArrayList<Order>();
                    ArrayList<Order> rejectedOrders = new ArrayList<Order>();
                    for (Order order : orderList) {

                        if (order.getStatus().equals("pending")) {
                            pendingOrders.add(order);
                        } else if (order.getStatus().equals("approved")) {
                            completedOrders.add(order);
                        } else if (order.getStatus().equals("rejected")) {
                            rejectedOrders.add(order);
                        }
                    }
                %>

                <!--tabs menu-->
                <div class="ui pointing secondary menu">
                    <a class="item active" data-tab="first">Pending Orders</a>
                    <a class="item" data-tab="second">Completed Orders</a>
                    <a class="item" data-tab="third">Rejected Orders</a>
                </div>

                <!--Pending orders section-->
                <div class="ui tab segment active" data-tab="first">
                    <%
                        int pendingList = pendingOrders.size();
                        int pendingPageNo = pendingList / 10;
                        if (pendingPageNo > 0) {
                            if (pendingList % 10 != 0) {
                                pendingPageNo++;
                            }
                        }

                    %>


                    <!--printing first 10 pendings orders-->
                    <div class="ui active tab middle aligned animated selection divided list" data-tab="11">


                        <%for (int count = 0; count < 10; count++) {
                                if (pendingOrders.size() > count) {

                                    Order order = pendingOrders.get(count);
                        %>



                        <div class="item test dish" data-content="Click to view order details"  data-variation="inverted">

                            <a href="OrderView.jsp?order_id=<%=order.getOrder_id()%>" >
                                <div class="content">
                                    <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%>
                                </div>
                                <div>
                                    Price: $<%=order.getTotal_final_price()%> &nbsp;
                                    Supplier: <%=order.getVendor_id()%>

                                </div>
                            </a>
                        </div>

                        <%}
                            }%>


                    </div>


                    <!--Printing the beyond the 10th pending order-->
                    <%
                        for (int j = 2; j <= pendingPageNo; j++) {
                    %>

                    <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 10%>">

                        <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                if (pendingOrders.size() > count) {

                                    Order order = pendingOrders.get(count);
                        %>



                        <div class="item test dish" data-content="Click to view order details"  data-variation="inverted">

                            <a href="OrderView.jsp?order_id=<%=order.getOrder_id()%>" >
                                <div class="content">
                                    <h2><%=order.getOrder_id()%></h2>
                                </div>
                                <div>
                                    <%=order.getDtOrder()%>
                                </div>
                            </a>
                        </div>



                        <%}
                            }%>
                    </div>

                    <%}%>


                    <div>
                        <%
                            if (pendingPageNo > 1) {
                        %>
                        <div class="ui pagination secondary menu">
                            <a class="active item" data-tab="11">
                                1
                            </a>
                            <%
                                for (int j = 1; j < pendingPageNo; j++) {
                            %>
                            <a class="item" data-tab="<%=j + 11%>">
                                <%=j + 1%>
                            </a>
                            <%}%>
                        </div>
                        <% }
                        %>

                    </div>
                </div>



                <!--Start of section for completed orders-->
                <div class="ui tab segment" data-tab="second">

                    <%
                        int completeList = completedOrders.size();
                        int completePageNo = completeList / 10;
                        if (completePageNo
                                > 0) {
                            if (completeList % 10 != 0) {
                                completePageNo++;
                            }
                        }

                        if (completePageNo
                                > 1) {
                    %>
                    <div class="ui pagination secondary menu">
                        <a class="active item" data-tab="21">
                            1
                        </a>
                        <%
                            for (int j = 1; j < completePageNo; j++) {
                        %>
                        <a class="item" data-tab="<%=j + 21%>">
                            <%=j + 1%>
                        </a>
                        <%}%>
                    </div>
                    <% }
                    %>
                    <div class="ui tab active segment" data-tab="21">
                        <ul>
                            <%for (int count = 0;
                                        count < 10; count++) {
                                    if (completedOrders.size() > count) {
                            %>
                            <li>
                                <%= completedOrders.get(count)%>
                            </li>  <%}
                                }%>
                        </ul>
                    </div>
                    <%
                        for (int j = 2;
                                j <= completePageNo;
                                j++) {
                    %>

                    <div class="ui tab segment" data-tab="<%=j + 20%>">
                        <ul>
                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (completedOrders.size() > count) {
                            %>

                            <li>
                                <%= completedOrders.get(count)%>
                            </li>  <%}
                                }%>
                        </ul>
                    </div>
                    <%}%>


                </div>



                <div class="ui tab segment" data-tab="third">
                    <ul>
                        <%for (Order order : rejectedOrders) {%>

                        <li><%=order%></li>
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
