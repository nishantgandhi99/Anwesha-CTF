<%-- 
    Document   : LoginForFlag
    Created on : Jan 31, 2014, 3:47:20 PM
    Author     : nishant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="../Images/favicon.ico">

        <title>Capture The Flag-Anwesha 2014</title>

        <!-- Bootstrap core CSS -->
        <link href="../dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/sticky-footer.css" rel="stylesheet">
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link href="../css/bootstrap-theme.css" rel="stylesheet">
        <link href="../css/jumbotron.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy this line! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->


    </head>

    <body  style=" background-color: #000">
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!--  <a class="navbar-brand" href="index.html">Capture The Flag</a>
                      <a class="navbar-brand" href="http://2014.anwesha.info/" target="_blank">Anwesha 2014</a> 
                    -->
                </div>
            </div>
        </div>

        <!-- Main jumbotron for a primary marketing message or call to action -->
        <%
            String data;
            if (request.getParameter("submit") != null) {
                if (request.getParameter("submit").equals("Submit")) {
                    if (request.getParameter("Passwd") != null && request.getParameter("Aid") != null) {
                        if (!(request.getParameter("hidden").equals("nologin"))) {
                            out.print("Flag=But_i_was_hidden");
                        } else {
                            out.print("Msg:Incorrect try");
                        }
                    } else {
                        out.print("Msg:Incorrect try");
                    }
                } else {
                    out.print("Msg:Incorrect try");
                }
            }

        %>
        <div class="jumbotron"  style="background-color: black">
            <div class="container">
                <center> <h1 class="greentext">Good you reached third problem</h1></center><br/>
                <!-- /container -->
                <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
                <!--[if lt IE 9]>
                <!-- 
                  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
                  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
                <![endif]-->
                <center> <h3 style=" color: red">Login to get the flag</h3></center>
                <table   style=" background-color: black">
                    <tr>
                        <td style="background-color: black">
                            <!--      <center>    <img src="./Images/Capture_the_flag copy.jpg" style=" position:  inherit"> </center> -->
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <form  action="#" method="post" style="">
            <center>  
                <fieldset class="the-fieldset">
                    <input type="text" placeholder="Enter Login Name:" name="Aid"/><br/>
                    <input type="password" placeholder="Password:" name="Passwd"/><br/>
                    <input type="hidden" name="hidden" value="nologin"/>
                    <button class="btn btn-success" align="left" type="submit" name="submit" value="Submit">Submit</button>     

                </fieldset>
            </center>
        </form>
        <p class="greentext">
            <%     String d;
                if (request.getParameter("submit") != null) {
                    if (request.getParameter("submit").equals("Submit")) {
                        if (request.getParameter("Passwd") != null && request.getParameter("Aid") != null) {
                            if (!(request.getParameter("hidden").equals("nologin"))) {
                                out.print("you made it:you are two click away from flag");
                            } else {
                                out.print("Msg:Incorrect try");
                            }
                        } else {
                            out.print("Msg:Incorrect try");
                        }
                    } else {
                        out.print("Msg:Incorrect try");
                    }
                }

            %>
        </p>
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->

        <script src="dist/css/bootstrap.min.js"></script>
        <script src="dist/js/bootstrap.js"></script>
    </body>
</html>
