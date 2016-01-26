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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/1.11.8/semantic.min.js"></script>
        <link rel="stylesheet" href="css/main.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script>
            $(document).on("click", ".show", function () {
                $(".ui.basic.modal").modal("show");
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
        <div class="ui attached stackable menu">
            <div class="ui container" >
                <a href="Home.jsp" class="item">
                    <i class="shop icon"></i> Order
                </a>
                <a class="item">
                    <i class="food icon"></i> Menu
                </a>
                <a class="item">
                    <div class="show">

                        <i class="ui mail icon"></i> Messages
                    </div>
                </a>
                <div class="ui simple dropdown item">
                    <i class="user icon"></i> My Account

                    <div class="menu">
                        <a class="item"><i class="edit icon"></i> Edit Profile</a>
                        <a class="item"><i class="settings icon"></i> Account Settings</a>
                    </div>
                </div>
            </div>
        </div>


        <div class="ui basic modal">
            <i class="close icon"></i>
            <div class="header">
                Messages
            </div>
            <div class="image content">
                <div class="ui medium image">
                    <img src="./resource/pictures/underconstruction.PNG">
                </div>
                <div class="description">
                    <div class="ui header" style="color: white">Coming soon..</div>
                    <p>Feature currently being developed. You will be notified about the launch of this feature.</p>
                    <p>Users may send mails and receive alerts about orders.</p>
                </div>
            </div>
            <div class="actions">
                <button class="ui inverted orange button">Take me Back</button>
            </div>
        </div>
    </body>
</html>
