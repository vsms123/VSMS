<%@page import="Controller.IngredientController"%>
<%@page import="Model.Orderline"%>
<%@page import="Model.*"%>
<%@page import="Controller.UserController"%>
<%@page import="Controller.OrderController"%>
<%@page import="Model.Order"%>
<%@page import="Controller.ConnectionManager"%>
<%@page import="java.util.ArrayList"%>






<html>
    <head>
        <%@ include file="protect_supplier.jsp" %>
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

        <%            //ArrayList<Order> orderList = OrderController.retrieveOrderList(1);
            Supplier s = (Supplier) session.getAttribute("currentSupplier");
            if (s == null) {
                s = UserController.retrieveSupplierByID(1);
            }
            ArrayList<Order> orderList = OrderController.getSupplierOrders(s.getSupplier_id());
            ArrayList<Order> pendingOrders = new ArrayList<Order>();
            ArrayList<Order> completedOrders = new ArrayList<Order>();
            ArrayList<Order> rejectedOrders = new ArrayList<Order>();
        %>


        <script>
            $(document).ready(function () {
                $('.secondary.menu .item').tab();

                $('.test.order').popup({
                    position: 'top left'
                });



            <%
                for (Order orderModal : orderList) {
            %>
//              Will go through edit-dish-button1 or edit-dish-button2 (regarding the dish id)
                $(".test.order.<%=orderModal.getOrder_id()%>").click(function () {

                    $('#modalOrder<%=orderModal.getOrder_id()%>').modal('show');
                });

            <%}%>
            });

            //For mobile view, will implement later
            $(window).on('load resize', function () {
                var width = $(window).width();
                var height = $(window).height();

                if ((width <= 800) || (height <= 600)) {
                    $("#pc").css("display", "none");
                    $("#mobile").css("display", "");
                } else {

                    $("#mobile").css("display", "none");
                    $("#pc").css("display", "");
                }
            });
        </script>


    </head>
    <body class="background">


        <div class="transparency">


            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="SuppNavbar.jsp" %>

                <div id="pc" class="pusher">
                    <h1 style="color: black">Order History List</h1>

                    <%

                        //                    creation of order modals and sorting of orders done here
                        for (Order order : orderList) {
                    %>



                    <div id="modalOrder<%=order.getOrder_id()%>" class="ui modal">

                        <div class="header">
                            <h1>Order No. <%=order.getOrder_id()%></h1>
                        </div>
                        <div class="image content">
                            <div class="ui medium image">
                                <img src="./resource/pictures/Cart.png">
                            </div>
                            <div class="description">
                                <div class="ui header" style="color: black">
                                    Order ID : <%=order.getOrder_id()%> <br/>
                                    Supplier : <%=UserController.retrieveSupplierByID(order.getVendor_id()).getSupplier_name()%> <br/>
                                    Date : <%=order.getDtOrder()%> <br/><br/>
                                    Items:

                                </div>
                                <table class="ui single line table">
                                    <thead>
                                        <tr>
                                            <th><div class="ui ribbon label">No. </div></th>
                                    <th>Name</th>
                                    <th>Unit</th>
                                    <th>Price</th>
                                    </tr>
                                    </thead>
                                    <%
                                        int count = 0;
                                        for (Orderline orderLine : order.getOrderlines()) {
                                            count++;

                                    %>
                                    <tr>

                                        <td><div class="ui ribbon label"><%=count%> </div>&nbsp;</td>
                                        <td><%=orderLine.getIngredient_name()%> &nbsp;</td>

                                        <!--units to be edited-->
                                        <%--<%=IngredientController.getIngredient(Integer.toString(orderLine.getSupplier_id()), orderLine.getIngredient_name()).getSupplyUnit()%>--%>
                                        <td><%=orderLine.getQuantity()%> &nbsp;</td>
                                        <td>$<%=orderLine.getFinalprice()%>&nbsp;</td>

                                    </tr>
                                    <%}%>

                                </table>
                            </div>
                        </div>
                        <div class="actions">
                            <%
                                if (order.getStatus().equals("pending")) {
                            %>
                            <form action="SupplierProcessOrder.jsp" method="POST">
                                <input type="hidden" value="<%=order.getOrder_id()%>" name="order_id" />
                                <button onclick="return confirm('Are you sure you want to continue')"  class="ui deny inverted green button" name="action" type="submit" value="accept">Accept</button>
                                <button onclick="return confirm('Are you sure you want to continue')"  class="ui deny inverted red button" name="action" type="submit" value="reject">Reject</button>
                            </form><%
                                }
                            %>
                            <button class="ui deny inverted orange button">Take me Back</button>
                        </div>
                    </div>


                    <%
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
                        <div class="ui active tab middle aligned animated selection divided list" data-tab="101">


                            <%for (int count = 0; count < 10; count++) {
                                    if (pendingOrders.size() > count) {

                                        Order order = pendingOrders.get(count);
                            %>



                            <div  class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        <br>
                                        Price: $<%=order.getTotal_final_price()%> &nbsp;
                                        <br>
                                        &nbsp;


                                    </div>
                                    <div>
                                        <% int counter = 1;
                                            for (Orderline o : order.getOrderlines()) {
                                                if (counter <= 3) {
                                        %>
                                        <div><%=counter%>. <%=o.getIngredient_name()%> x <%=o.getQuantity()%></div>
                                        <%
                                                    counter++;
                                                }

                                            }
                                            if (counter > 3) {
                                        %>
                                        <br>
                                        Tap to view <%=counter - 2%> more item(s)
                                        <%
                                            }
                                        %>    
                                    </div>
                                </a>
                            </div>
                            <form action="SupplierProcessOrder.jsp" method="POST">
                                <input type="hidden" value="<%=order.getOrder_id()%>" name="order_id" />
                                <button class="ui deny inverted green button" name="action" type="submit" value="accept">Accept</button>
                                <button class="ui deny inverted red button" name="action" type="submit" value="reject">Reject</button>
                            </form>

                            <%}
                                }%>


                        </div>


                        <!--Printing the beyond the 10th pending order-->
                        <%
                            for (int j = 2;
                                    j <= pendingPageNo;
                                    j++) {
                        %>

                        <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 100%>">

                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (pendingOrders.size() > count) {

                                        Order order = pendingOrders.get(count);
                            %>


                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>



                            <%}
                                }%>
                        </div>

                        <%}%>


                        <!--Start of pagination-->
                        <div>
                            <%
                                if (pendingPageNo
                                        > 1) {
                            %>
                            <div class="ui pagination secondary menu">
                                <a class="active item" data-tab="101">
                                    1
                                </a>
                                <%
                                    for (int j = 1; j < pendingPageNo; j++) {
                                %>
                                <a class="item" data-tab="<%=j + 101%>">
                                    <%=j + 1%>
                                </a>
                                <%}%>
                            </div>
                            <% }
                            %>

                        </div>
                        <!--End of pagination-->
                    </div>


















                    <!--Start of section for completed orders-->
                    <div class="ui tab segment" data-tab="second">

                        <%
                            int completedList = completedOrders.size();
                            int completedPageNo = completedList / 10;
                            if (completedPageNo
                                    > 0) {
                                if (completedList % 10 != 0) {
                                    completedPageNo++;
                                }
                            }

                        %>





                        <!--printing first 10 completed orders-->  

                        <div class="ui active tab middle aligned animated selection divided list" data-tab="201">


                            <%for (int count = 0;
                                        count < 10; count++) {
                                    if (completedOrders.size() > count) {

                                        Order order = completedOrders.get(count);
                            %>



                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>

                            <%}
                                }%>

                        </div>
                        <!--end of printing first 10 completed orders-->  





                        <!--Printing the beyond the 10th completed order-->
                        <%
                            for (int j = 2;
                                    j <= completedPageNo;
                                    j++) {
                        %>

                        <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 200%>">

                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (completedOrders.size() > count) {

                                        Order order = completedOrders.get(count);
                            %>


                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>



                            <%}
                                }%>
                        </div>

                        <%}%>

                        <!--end of Printing the beyond the 10th completed order-->




                        <!--Start of pagination-->
                        <div>
                            <%
                                if (completedPageNo
                                        > 1) {
                            %>
                            <div class="ui pagination secondary menu">
                                <a class="active item" data-tab="201">
                                    1
                                </a>
                                <%
                                    for (int j = 1; j < completedPageNo; j++) {
                                %>
                                <a class="item" data-tab="<%=j + 201%>">
                                    <%=j + 1%>
                                </a>
                                <%}%>
                            </div>
                            <% }
                            %>

                        </div>

                        <!--End of pagination-->  

                    </div>





























                    <!--Start of Rejected Orders section-->

                    <div class="ui tab segment" data-tab="third">





                        <%
                            int rejectedList = rejectedOrders.size();
                            int rejectedPageNo = rejectedList / 10;
                            if (rejectedPageNo
                                    > 0) {
                                if (rejectedList % 10 != 0) {
                                    rejectedPageNo++;
                                }
                            }

                        %>





                        <!--printing first 10 completed orders-->  

                        <div class="ui active tab middle aligned animated selection divided list" data-tab="301">


                            <%for (int count = 0;
                                        count < 10; count++) {
                                    if (rejectedOrders.size() > count) {

                                        Order order = rejectedOrders.get(count);
                            %>



                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>

                            <%}
                                }%>

                        </div>
                        <!--end of printing first 10 completed orders-->  





                        <!--Printing the beyond the 10th completed order-->
                        <%
                            for (int j = 2;
                                    j <= rejectedPageNo;
                                    j++) {
                        %>

                        <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 300%>">

                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (rejectedOrders.size() > count) {

                                        Order order = rejectedOrders.get(count);
                            %>


                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>



                            <%}
                                }%>
                        </div>

                        <%}%>

                        <!--end of Printing the beyond the 10th completed order-->




                        <!--Start of pagination-->
                        <div>
                            <%
                                if (rejectedPageNo
                                        > 1) {
                            %>
                            <div class="ui pagination secondary menu">
                                <a class="active item" data-tab="301">
                                    1
                                </a>
                                <%
                                    for (int j = 1; j < rejectedPageNo; j++) {
                                %>
                                <a class="item" data-tab="<%=j + 301%>">
                                    <%=j + 1%>
                                </a>
                                <%}%>
                            </div>
                            <% }
                            %>

                        </div>

                        <!--End of pagination-->  
                    </div>
                </div>



                <!--MOBILE VIEW START-->

                <div id="mobile" class="pusher">
                    <h1 style="color: black">Order History List</h1>

                    <%
                        //                    creation of order modals and sorting of orders done here
                        for (Order order : orderList) {
                    %>



                    <div id="modalOrder<%=order.getOrder_id()%>" class="ui modal">

                        <div class="header">
                            <h1>Order No. <%=order.getOrder_id()%></h1>
                        </div>
                        <div class="image content">
                            <div class="ui medium image">
                                <img src="./resource/pictures/Cart.png">
                            </div>
                            <div class="description">
                                <div class="ui header" style="color: black">
                                    Order ID : <%=order.getOrder_id()%> <br/>
                                    Supplier : <%=UserController.retrieveSupplierByID(order.getVendor_id()).getSupplier_name()%> <br/>
                                    Date : <%=order.getDtOrder()%> <br/><br/>
                                    Items:

                                </div>
                                <table class="ui single line table">
                                    <thead>
                                        <tr>
                                            <th><div class="ui ribbon label">No. </div></th>
                                    <th>Name</th>
                                    <th>Unit</th>
                                    <th>Price</th>
                                    </tr>
                                    </thead>
                                    <%
                                        int count = 0;
                                        for (Orderline orderLine : order.getOrderlines()) {
                                            count++;

                                    %>
                                    <tr>

                                        <td><div class="ui ribbon label"><%=count%> </div>&nbsp;</td>
                                        <td><%=orderLine.getIngredient_name()%> &nbsp;</td>

                                        <!--units to be edited-->
                                        <%--<%=IngredientController.getIngredient(Integer.toString(orderLine.getSupplier_id()), orderLine.getIngredient_name()).getSupplyUnit()%>--%>
                                        <td><%=orderLine.getQuantity()%> &nbsp;</td>
                                        <td>$<%=orderLine.getFinalprice()%>&nbsp;</td>

                                    </tr>
                                    <%}%>

                                </table>
                            </div>
                        </div>
                        <div class="actions">
                            <%
                                if (order.getStatus().equals("pending")) {
                            %>
                            <form action="SupplierProcessOrder.jsp" method="POST">
                                <input type="hidden" value="<%=order.getOrder_id()%>" name="order_id" />
                                <button onclick="return confirm('Are you sure you want to continue')"  class="ui deny inverted green button" name="action" type="submit" value="accept">Accept</button>
                                <button onclick="return confirm('Are you sure you want to continue')"  class="ui deny inverted red button" name="action" type="submit" value="reject">Reject</button>
                            </form><%
                                }
                            %>
                            <button class="ui deny inverted orange button">Take me Back</button>
                        </div>
                    </div>


                    <%
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
                            int pendingList2 = pendingOrders.size();
                            int pendingPageNo2 = pendingList2 / 10;
                            if (pendingPageNo2 > 0) {
                                if (pendingList2 % 10 != 0) {
                                    pendingPageNo2++;
                                }
                            }

                        %>


                        <!--printing first 10 pendings orders-->
                        <div class="ui active tab middle aligned animated selection divided list" data-tab="101">


                            <%for (int count = 0; count < 10; count++) {
                                    if (pendingOrders.size() > count) {

                                        Order order = pendingOrders.get(count);
                            %>



                            <div  class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        <br>
                                        Price: $<%=order.getTotal_final_price()%> &nbsp;
                                        <br>
                                        &nbsp;


                                    </div>
                                    <div>
                                        <% int counter = 1;
                                            for (Orderline o : order.getOrderlines()) {
                                                if (counter <= 3) {
                                        %>
                                        <div><%=counter%>. <%=o.getIngredient_name()%> x <%=o.getQuantity()%></div>
                                        <%
                                                    counter++;
                                                }

                                            }
                                            if (counter > 3) {
                                        %>
                                        <br>
                                        Tap to view <%=counter - 2%> more item(s)
                                        <%
                                            }
                                        %>    
                                    </div>
                                </a>
                            </div>
                            <form action="SupplierProcessOrder.jsp" method="POST">
                                <input type="hidden" value="<%=order.getOrder_id()%>" name="order_id" />
                                <button class="ui deny inverted green button" name="action" type="submit" value="accept">Accept</button>
                                <button class="ui deny inverted red button" name="action" type="submit" value="reject">Reject</button>
                            </form>

                            <%}
                                }%>


                        </div>


                        <!--Printing the beyond the 10th pending order-->
                        <%
                            for (int j = 2;
                                    j <= pendingPageNo;
                                    j++) {
                        %>

                        <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 100%>">

                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (pendingOrders.size() > count) {

                                        Order order = pendingOrders.get(count);
                            %>


                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>



                            <%}
                                }%>
                        </div>

                        <%}%>


                        <!--Start of pagination-->
                        <div>
                            <%
                                if (pendingPageNo
                                        > 1) {
                            %>
                            <div class="ui pagination secondary menu">
                                <a class="active item" data-tab="101">
                                    1
                                </a>
                                <%
                                    for (int j = 1; j < pendingPageNo; j++) {
                                %>
                                <a class="item" data-tab="<%=j + 101%>">
                                    <%=j + 1%>
                                </a>
                                <%}%>
                            </div>
                            <% }
                            %>

                        </div>
                        <!--End of pagination-->
                    </div>


















                    <!--Start of section for completed orders-->
                    <div class="ui tab segment" data-tab="second">

                        <%
                            int completedList2 = completedOrders.size();
                            int completedPageNo2 = completedList2 / 10;
                            if (completedPageNo2
                                    > 0) {
                                if (completedList2 % 10 != 0) {
                                    completedPageNo2++;
                                }
                            }

                        %>





                        <!--printing first 10 completed orders-->  

                        <div class="ui active tab middle aligned animated selection divided list" data-tab="201">


                            <%for (int count = 0;
                                        count < 10; count++) {
                                    if (completedOrders.size() > count) {

                                        Order order = completedOrders.get(count);
                            %>



                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>

                            <%}
                                }%>

                        </div>
                        <!--end of printing first 10 completed orders-->  





                        <!--Printing the beyond the 10th completed order-->
                        <%
                            for (int j = 2;
                                    j <= completedPageNo;
                                    j++) {
                        %>

                        <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 200%>">

                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (completedOrders.size() > count) {

                                        Order order = completedOrders.get(count);
                            %>


                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>



                            <%}
                                }%>
                        </div>

                        <%}%>

                        <!--end of Printing the beyond the 10th completed order-->




                        <!--Start of pagination-->
                        <div>
                            <%
                                if (completedPageNo
                                        > 1) {
                            %>
                            <div class="ui pagination secondary menu">
                                <a class="active item" data-tab="201">
                                    1
                                </a>
                                <%
                                    for (int j = 1; j < completedPageNo; j++) {
                                %>
                                <a class="item" data-tab="<%=j + 201%>">
                                    <%=j + 1%>
                                </a>
                                <%}%>
                            </div>
                            <% }
                            %>

                        </div>

                        <!--End of pagination-->  

                    </div>





























                    <!--Start of Rejected Orders section-->

                    <div class="ui tab segment" data-tab="third">





                        <%
                            int rejectedList2 = rejectedOrders.size();
                            int rejectedPageNo2 = rejectedList2 / 10;
                            if (rejectedPageNo2
                                    > 0) {
                                if (rejectedList2 % 10 != 0) {
                                    rejectedPageNo2++;
                                }
                            }

                        %>





                        <!--printing first 10 completed orders-->  

                        <div class="ui active tab middle aligned animated selection divided list" data-tab="301">


                            <%for (int count = 0;
                                        count < 10; count++) {
                                    if (rejectedOrders.size() > count) {

                                        Order order = rejectedOrders.get(count);
                            %>



                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>

                            <%}
                                }%>

                        </div>
                        <!--end of printing first 10 completed orders-->  





                        <!--Printing the beyond the 10th completed order-->
                        <%
                            for (int j = 2;
                                    j <= rejectedPageNo;
                                    j++) {
                        %>

                        <div class="ui tab middle aligned animated selection divided list" data-tab="<%=j + 300%>">

                            <%for (int count = (j - 1) * 10; count < j * 10; count++) {
                                    if (rejectedOrders.size() > count) {

                                        Order order = rejectedOrders.get(count);
                            %>


                            <div class="item test order <%=order.getOrder_id()%>" id="<%=order.getOrder_id()%>" data-content="Click to view order details"  data-variation="inverted">

                                <a>
                                    <div class="content">
                                        <h2>Order No. <%=order.getOrder_id()%></h2> <%=order.getDtOrder()%> 
                                    </div>
                                    <div>
                                        Vendor: <%=UserController.retrieveVendorByID(order.getVendor_id()).getVendor_name()%> &nbsp;
                                        Price: $<%=order.getTotal_final_price()%> 


                                    </div>
                                </a>
                            </div>



                            <%}
                                }%>
                        </div>

                        <%}%>

                        <!--end of Printing the beyond the 10th completed order-->




                        <!--Start of pagination-->
                        <div>
                            <%
                                if (rejectedPageNo
                                        > 1) {
                            %>
                            <div class="ui pagination secondary menu">
                                <a class="active item" data-tab="301">
                                    1
                                </a>
                                <%
                                    for (int j = 1; j < rejectedPageNo; j++) {
                                %>
                                <a class="item" data-tab="<%=j + 301%>">
                                    <%=j + 1%>
                                </a>
                                <%}%>
                            </div>
                            <% }
                            %>

                        </div>

                        <!--End of pagination-->  
                    </div>
                </div>
                <!--MOBILE VIEW END HERE-->


                <!--                  
                  Sidebar comes here
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
                -->


                <!--JAVASCRIPT-->
                <!--for general Javascript please refer to the main js. For others, please just append the script line below-->
                <script src="js/main.js" type="text/javascript"></script>

            </div>
        </div>
    </body>
</html>
