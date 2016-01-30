<%-- 
    Document   : Navbar
    Created on : Jan 23, 2016, 11:47:13 PM
    Author     : Benjamin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script>
            $(document).ready(function () { 
                 $('.message').click(function () {
                    //show modal button
                    $('#modalMessage').modal('show');
                });

            });
        </script>


    </head>
    <body>
        <div class="ui grid">
            <div class="six wide column">
                <img class="logo" src="./resource/pictures/logofinal.png">
            </div>
            <div class="ten wide column" style="position:relative;top: 50px">
                Find ingredients that you need

                <div class="ui fluid action input" style="margin-right: 10%">
                    <input type="text" placeholder="Search suppliers, ingredients...">
                    <div class="ui button"> <i class="search icon"></i></div>
                </div>
            </div>

        </div>

        <div class="ui stackable menu">
            <a href="Home.jsp" class="item">
                <h3> <i class="large shop icon"></i> &nbsp Order</h3>
            </a>
            <a href="Menu.jsp" class="item">
                <h3> <i class="large food icon"></i>&nbsp Menu</h3>
            </a>
            <a class="item message">
                <h3> <i class="large  mail icon"></i>&nbsp Messages</h3>
            </a>
            <div class="ui simple dropdown item">
               <h3> <i class="large user icon"></i> &nbsp My Account</h3>

                <div class="menu">
                   <h3> <a class="item"><i class="large edit icon"></i> Edit Profile</a></h3>
                   <h3> <a class="item"><i class="large settings icon"></i> Account Settings</a></h3>
                </div>
            </div>
        </div>






        <div id="modalMessage" class="ui basic modal">
            <i class="close icon"></i>
            <div class="header">
                <h1>Messages</h1>
            </div>
            <div class="image content">
                <div class="ui medium image">
                    <img src="./resource/pictures/underconstruction.PNG">
                </div>
                <div class="description">
                    <p><h2>Users may send mails to friends and receive alerts about new updates.</h2></p>
                    <div class="ui header" style="color: white">Coming soon..</div>
                    <p>Feature currently being developed. You will be notified about the launch of this feature.</p>

                </div>
            </div>
            <div class="actions">
                <button class="ui inverted deny orange button">Take me Back</button>
            </div>
        </div>
    </body>
</html>
