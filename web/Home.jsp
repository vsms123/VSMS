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
            $(document).on("click", ".show", function () {
                $(".ui.modal").modal("show");
            });
        </script>
        <title>Main Menu</title>
    </head>


    <body class="background">
        

        <div class="transparency">
  
            <div class="ui segment" style="left:5%;width:90%">
                <%@ include file="Navbar.jsp" %>
               
                <p></p>
                <div class="ui breadcrumb" >
                    <a class="section">Home</a>
                    <i class="right angle icon divider"></i>
                    <a class="section">Manage Menu</a>
                    <i class="right angle icon divider"></i>
                    <div class="active section">Recipe Buider</div>
                </div>
                <div class="ui raised very padded text container">
                    <p></p>
                    <h2 class="ui header">VSMS Menu</h2>
                         
                    <p></p>
                    
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
    </body>
</html>
