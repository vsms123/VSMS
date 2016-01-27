<%-- 
    Document   : Analytics Test
    Created on : Jan 27, 2016, 4:45:38 PM
    Author     : vincentt.2013
--%>

<%@page import="Controller.OrderController"%>
<%@page import="Controller.IngredientController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {packages: ['corechart']});
            google.charts.setOnLoadCallback(drawDishChart);
            google.charts.setOnLoadCallback(drawOrderChart);
            google.charts.setOnLoadCallback(drawBarChart);
            function drawDishChart() {
                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Dishes');
                data.addColumn('number', '#ofIngredients');
                data.addRows(<%=IngredientController.getDishDataTable()%>);

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
            function drawOrderChart() {
                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Vendor');
                data.addColumn('number', '#ofOrders');
                data.addRows(<%=OrderController.getVendorOrderDataTable()%>);

                // Set chart options
                var options = {'title': 'Vendor and Orders created',
                    'width': 400,
                    'height': 300};

                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('chart_order_pie_div'));

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
            function drawBarChart() {

                var data = google.visualization.arrayToDataTable([
                    ['City', '2010 Population', ],
                    ['New York City, NY', 8175000],
                    ['Los Angeles, CA', 3792000],
                    ['Chicago, IL', 2695000],
                    ['Houston, TX', 2099000],
                    ['Philadelphia, PA', 1526000]
                ]);

                var options = {
                    title: 'Population of Largest U.S. Cities',
                    chartArea: {width: '50%'},
                    hAxis: {
                        title: 'Total Population',
                        minValue: 0
                    },
                    vAxis: {
                        title: 'City'
                    }
                };

                var chart = new google.visualization.BarChart(document.getElementById('chart_bar_div'));

                chart.draw(data, options);
            }
        </script>
    </head>
    <body>
        <!-- Identify where the pie chart should be drawn. -->
        <div id="chart_dish_pie_div"></div>
        <!-- Identify where the pie chart should be drawn. -->
        <div id="chart_order_pie_div"></div>
        <!-- Identify where the bar chart should be drawn. -->
        <div id="chart_bar_div"></div>
    </body>
</html>