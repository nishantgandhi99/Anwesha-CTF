<%-- 
    Document   : prompt
    Created on : Jan 31, 2014, 1:04:20 PM
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

        <script language="javascript">
            var p = prompt('Authorized Access Only.\n Enter Password: ', 'Enter the password');
            if (p == "JokerIsFunny")
                alert('Good');
            else
                window.location.reload();
        </script>
        <%
            String data;
            if (request.getParameter("submit") != null) {
                if (request.getParameter("submit").equals("Submit")) {
                    if (request.getParameter("pass") != null) {
                        if (request.getParameter("pass").equals("apherall")) {
                            out.print("Flag=javascipt_is_pain_in_a**");
                        }
                    }
                }
            }
        %>
    </head>
    <body  style=" background-color: #000" >
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
                <center> <h1 class="greentext">Enter the Password</h1></center><br/>
                <center> <h3 style=" color: red">Find the flag</h3></center>
            </div>
        </div>
    <center><p class="greentext"><b> Password is 'apherall' </b></p> </center>
    <center>
        <form method="post" action="#">   
            <table>
                <tr>
                    <td>
                        <p class="greentext"><b>  Password:  </b></p> 
                    </td>
                    <td>
                        <input type="password" name="pass" size="10" maxlength="6">
                    </td>
                </tr>
                <tr>
                    <td>

                    </td>
                    <td>
                        <input type="submit" name="submit" value="Submit">
                    </td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>
