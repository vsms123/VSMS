<%-- 
    Document   : MainMenu
    Created on : Jan 18, 2016, 1:03:48 PM
    Author     : Benjamin
--%>

<%@page import="Model.ShoppingCart"%>
<%@page import="DAO.IngredientDAO"%>
<%@page import="Controller.IngredientController"%>
<%@page import="Controller.OrderController"%>
<%@page import="Controller.UserController"%>
<%@page import="Model.Vendor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <%@ include file="protect.jsp" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
            //in case current vendor does not exist
            if (currentVendor == null) {
                currentVendor = UserController.retrieveVendorByID(1);
            }
            int vendor_id = currentVendor.getVendor_id();
//Creates a shopping cart whenever a user logs in to be used by that user
            ShoppingCart cart=new ShoppingCart(IngredientDAO.getDishID(vendor_id+""),"Shopping Cart", vendor_id, "A cart to place your ingredients in");
            session.setAttribute("ShoppingCart",cart);
//End of shopping cart creation
        %>
        <script>
            $(document).ready(function() {
                $('.message').click(function() {
                    //show modal button
                    $('#modalMessage').modal('show');
                });
                $('.profile').click(function() {
                    //show modal button
                    $('#modalAccount').modal('show');
                });

//              //For mobile view, will implement later
//                $(window).on('load resize', function () {
//                    var width = $(window).width();
//                    var height = $(window).height();
//
//                    if ((width <= 800) || (height <= 600)) {
//                        $("#pc").css("display", "none");
//                        $("#mobile").css("display", "");
//                    } else {
//                        
//                        $("#mobile").css("display", "none");
//                        $("#pc").css("display", "");
//                    }
//                });

            });
        </script>

        <!--//------------------------ANALYTICS------------------------------>

        <script type="text/javascript">
            google.charts.load('current', {packages: ['corechart', 'table']});
            google.charts.setOnLoadCallback(drawSupplierSalesAmountChart);
            google.charts.setOnLoadCallback(drawDishChart);
            google.charts.setOnLoadCallback(drawTimeChart);
            function drawSupplierSalesAmountChart() {
                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Supplier');
                data.addColumn('number', 'Sales Amount');
                data.addRows(<%=OrderController.getSupplierSalesAmountDataTable(vendor_id)%>);

                // Set chart options
                var options = {'title': 'Supplier and Sales Amount created',
                    'width': 400,
                    'height': 300};

                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('chart_supplier_sales_amount_pie_div'));

                function selectHandler() {
                    var selectedItem = chart.getSelection()[0];
                    if (selectedItem) {
                        var topping = data.getValue(selectedItem.row, 0);
                        alert('The user selected ' + topping);
                    }
                }

                google.visualization.events.addListener(chart, 'select', selectHandler);
                chart.draw(data, options);
            }
            function drawDishChart() {
                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Dishes');
                data.addColumn('number', '#ofIngredients');
                data.addRows(<%=IngredientController.getDishDataTable(vendor_id)%>);

                // Set chart options
                var options = {'title': 'Dishes and Ingredients created',
                    'width': 400,
                    'height': 300};

                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('chart_dish_pie_div'));

                function selectHandler() {
                    var selectedItem = chart.getSelection()[0];
                    if (selectedItem) {
                        var topping = data.getValue(selectedItem.row, 0);
                        alert('The user selected ' + topping);
                    }
                }

                google.visualization.events.addListener(chart, 'select', selectHandler);
                chart.draw(data, options);
            }
            function drawTimeChart() {

                var data = new google.visualization.DataTable();
                data.addColumn('date', 'Time of Day');
                data.addColumn('number', '#Orders Made');

                data.addRows(<%=OrderController.getDateOrderDataTable(currentVendor.getVendor_id())%>);


                var options = {
                    title: 'Orders Made',
                    width: 900,
                    height: 500,
                    hAxis: {
                        format: 'dd/M/yyyy',
                        gridlines: {count: 15}
                    },
                    vAxis: {
                        gridlines: {color: 'none'},
                        minValue: 0
                    }
                };

                var chart = new google.visualization.LineChart(document.getElementById('order_timeline_div'));

                chart.draw(data, options);

                var button = document.getElementById('change');

                button.onclick = function() {

                    // If the format option matches, change it to the new option,
                    // if not, reset it to the original format.
                    options.hAxis.format === 'M/d/yy' ?
                            options.hAxis.format = 'MMM dd, yyyy' :
                            options.hAxis.format = 'M/d/yy';

                    chart.draw(data, options);
                };
            }
        </script>
        <script>
            $(document).ready(function() {
                $('#testing').click(function() {
                    $('.vertical.menu').sidebar('toggle');
                });
            });
        </script>
        <script>
            $(document).ready(function() {
                $("#testing").click(function() {
                    $('.vertical.menu').sidebar('toggle');
                });

            });
        </script>



        <title>Main Menu</title>
    </head>



    <body>

        <div id="pc" class="background">


            <div class="transparency">


                <div  class="ui segment" style="left:5%;width:90%">

                    <%@ include file="Navbar.jsp" %>

                    <p></p>


                    <div class="ui raised very padded text container">
                        <p></p>
                        <h1 class="ui header">VSMS Menu</h1>

                        <p></p>
                        <h1>We will be adding in more contents here, such as some order status and notifications </h1>
                        <!-- Identify where the pie chart should be drawn. -->
                        <div id="chart_supplier_sales_amount_pie_div"></div> 
                        <!-- Identify where the pie chart should be drawn. -->
                        <div id="chart_dish_pie_div"></div>
                        <!-- Identify where the timeline chart should be drawn. -->
                        <div id="order_timeline_div"></div>

                        <p></p>


                        <p></p>
                    </div>


                    <div class="ui left rail">
                        <div class="ui">
                            <%--
                            content
                            --%>
                        </div>
                    </div>
                    <div class="ui right rail">
                        <div class="ui">
                            <%--
                           content
                            --%>
                        </div>
                    </div>
                    <p></p>
                    <p></p>
                </div>


            </div>
        </div>


        <!--For mobile view will fix later-->

        <!--        <div id="mobile" class="pusher">
                    Testing
                    <button id="testing">Sidebar</button>
                </div>
                                
                                
                                
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
                </div>-->
    </body>
</html>
