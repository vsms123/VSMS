<%-- 
    Document   : MainMenu
    Created on : Jan 18, 2016, 1:03:48 PM
    Author     : Benjamin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
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
                $('.profile').click(function () {
                    //show modal button
                    $('#modalAccount').modal('show');
                });


                $(window).on('load resize', function () {
                    var width = $(window).width();
                    var height = $(window).height();

                    if ((width <= 800) || (height <= 600)) {
                        $("#pc").css("display", "none");
                        $("#mobile").css("display", "");
                    } else {
                        $("#pc").css("display", "");
                        $("#mobile").css("display", "none");
                    }
                });


            });
        </script>
        <script>
            $(document).ready(function () {
                $("#testing").click(function () {
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
                    <div class="ui breadcrumb" >
                        <div class="active section">Home</div>
                    </div>

                    <div class="ui raised very padded text container">
                        <p></p>
                        <h1 class="ui header">VSMS Menu</h1>

                        <p></p>
                        <h1>We will be adding in more contents here, such as some order status and notifications </h1>



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

        <div id="mobile" class="pusher">
            Testing
            <button id="testing">Sidebar</button>
        </div>
                        
                        
                        
        <!--Sidebar comes here-->
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
    </body>
</html>
