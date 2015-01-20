<%-- 
    Document   : Select
    Created on : Jan 31, 2014, 5:00:45 PM
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
        <link href="../css/jumbotron.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy this line! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
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

        <div class="jumbotron"  style="background-color: black">
            <div class="container">
                <center> <h1 class="greentext">So back to pure HTML</h1></center><br/>
                <center> <h3 style=" color: red">Select my favorite fruit Mango from list to get flag.</h3></center>
                <br/><br/><br/>
                <p class="greentext">
                <form  action="#" method="post" style="">
                    <center>  
                        <fieldset class="the-fieldset">
                            <select name="dropselect">
                                <option value="Banana">Banana</option>
                                <option value="Orange">Orange</option>
                                <option value="Grapes">Grapes</option>
                                <option value="Apple">Apple</option>
                            </select><br/><br/><br/>
                            <button class="btn btn-success" align="left" type="submit" name="submit" value="Submit">Submit</button>     
                        </fieldset>
                    </center>
                </form>
                <p class="greentext">
                    <%
                        String d;
                        if (request.getParameter("submit") != null) {
                            if (request.getParameter("submit").equals("Submit")) {
                                if (request.getParameter("dropselect").equals("Mango")) {
                                    out.print("Flag:yummy_mango");
                                } else {
                                    out.print("Msg:Incorrect try");
                                }
                            }

                        }
                    %>
                </p>       
            </div>
        </div>
        <!-- /container -->
        <!-- Bootstrap core JavaScript
            ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->

        <script src="../dist/css/bootstrap.min.js"></script>
        <script src="../dist/js/bootstrap.js"></script>
    </body>
</html>
