<%-- 
    Document   : Login
    Created on : 20 Jan, 2016, 3:36:05 PM
    Author     : Benjamin
--%>

<%@page import="Model.Vendor"%>
<%@page import="Model.Supplier"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <!--Form VALIDATION-->
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
        <script src="js/formvalidation.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/login.css">
        <title>Login</title>
    </head>
    <body class="background">

        <img class="ui centered image" src="./resource/pictures/logofinal.png">

        <div class="box">

            <h1>Log In</h1>

            <%
                Vendor currentVendor = (Vendor) session.getAttribute("currentVendor");
                Supplier currentSupplier = (Supplier) session.getAttribute("currentSupplier");
                String errorMsg = (String) request.getParameter("errMsg");
                String succMsg = (String) request.getParameter("succMsg");
            %>

            <%
                if (errorMsg == null) {
                    errorMsg = "";
                }
                if (succMsg == null) {
                    succMsg = "";
                }
            %>

            <form id="login" action = "LoginServlet" method="post">
                <div class="input-group">
                    <input id="username" type="text" name="username" autocomplete="off" onblur="checkInput(this)" />
                    <label for="username">Username</label>
                </div>
                <div class="input-group">
                    <input id="password" type="password" name="password" onblur="checkInput(this)" />
                    <label for="password">Password</label>
                </div>
                <input type="submit" value="Enter" />
            </form>
            <p><%=errorMsg%></p>
            <p><%=succMsg%></p>
        </div>
    </body>



    <script>
        function checkInput(input) {
            if (input.value.length > 0) {
                input.className = 'active';
            } else {
                input.className = '';
            }
        }


    </script>
</html>
