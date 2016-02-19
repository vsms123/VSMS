<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.css"/>
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.8/semantic.min.js"></script>
        <link rel="stylesheet" href="css/main.css">

        <script>
            $(document).ready(function () {
                $('.message').click(function () {
                    //show modal button
                    $('#modalMessage').modal('show');
                });
                $('.profile').click(function () {
                    //show modal button
                    $('#modalAccount').modal('show');
                });

                $(window).on('load resize', function () {
                    var width = $(window).width();
                    var height = $(window).height();

                    if ((width <= 920) || (height <= 400)) {
                        $("#searchPC").css("display", "none");
                        $("#navbarPC").css("display", "none");
                        $("#PCview").css("display", "none");
                        
                        $("#navbarMobile").css("display", "");
                    } else {
                        $("#searchPC").css("display", "");
                        $("#navbarPC").css("display", "");
                        $("#PCview").css("display", "");
                        $("#navbarMobile").css("display", "none");
                    }
                });
                $('#ingredient-name-input').keypress(function (e) {
                    console.log("Keypress  is pressed");
                    if (e.which == 13) {
                        document.location.href = "SupplierSearch.jsp?ingredient_name=" + $('#ingredient-name-input').val();
                    }
                });
                $('#ingredient-name-input-button').click(function () {
                    document.location.href = "SupplierSearch.jsp?ingredient_name=" + $('#ingredient-name-input').val();
                });


            });


        </script>

    </head>
    <body>




        <div id="PCview" class="ui grid">
            <div class="six wide column">
                <a href="SupplierHome.jsp">
                    <img class="logo" src="./resource/pictures/logofinal.png">
                </a>

            </div>
        </div>

        <div id="navbarPC" class="ui stackable menu">
            <a href="SupplierHome.jsp" class="item" style=" font-size: 16px">
                <i class="large home icon"></i> Home
            </a>
            <a href="SupplierReviewOrders.jsp" class="item" style=" font-size: 16px">
               <i class="large edit icon"></i> Review Orders
            </a>
            
            <a class="item message" style=" font-size: 16px">
                <i class="large  mail icon"></i> Messages
            </a>
            <div class="ui simple dropdown item" style=" font-size: 16px">
                <i class="large user icon"></i>  My Account

                <div class="menu">
                    <a href="SupplierProfile.jsp" class="item" style=" font-size: 16px"><i class="large info icon"></i> View Profile</a>
                    <a class="item profile" style=" font-size: 16px"><i class="large settings icon"></i> Account Settings</a>
                </div>
            </div>
            <a href="LogoutServlet" class="item" style=" font-size: 16px">
                <i class="large search icon"></i> Log Out
            </a>


        </div>



        <div id="navbarMobile" class="ui top fixed inverted menu"> 
            <div class="item" style=" font-size: 16px">
                VSMS
            </div>
            <div class="right menu">
            <div class="ui simple dropdown item" style=" font-size: 16px">
                <i class="sidebar icon"></i> 

                <div class="menu">
                    <a href="SupplierReviewOrders.jsp" class="item" style=" font-size: 16px"><i class="large food icon"></i> Review Orders</a>
                    <a href="SupplierProfile.jsp" class="item" style=" font-size: 16px"><i class="large info icon"></i> View Profile</a>
                    <a class="item profile" style=" font-size: 16px"><i class="large settings icon"></i> Account Settings</a>
                </div>
            </div>
            </div>
        </div>


        <div id="modalMessage" class="ui basic modal">
            <i class="close icon"></i>
            <div class="header">
                <h1>Message</h1>
            </div>
            <div class="image content">
                <div class="ui medium image">
                    <img src="./resource/pictures/underconstruction.PNG">
                </div>
                <div class="description">
                    <p><h2>Users may check notifications and receive alerts about new updates.</h2></p>
                    <div class="ui header" style="color: white">Coming soon..</div>
                    <p>Feature currently being developed. You will be notified about the launch of this feature.</p>

                </div>
            </div>
            <div class="actions">
                <button class="ui inverted deny orange button">Take me Back</button>
            </div>
        </div>

        <div id="modalAccount" class="ui basic modal">
            <i class="close icon"></i>
            <div class="header">
                <h1>Account/Profile</h1>
            </div>
            <div class="image content">
                <div class="ui medium image">
                    <img src="./resource/pictures/underconstruction.PNG">
                </div>
                <div class="description">
                    <p><h2>Users manage their Account and Profile.</h2></p>
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
