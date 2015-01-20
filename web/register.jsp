<%-- 
    Document   : register
    Created on : Jan 29, 2014, 7:46:37 PM
    Author     : nishant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="./Images/favicon.ico">
        <title>Capture The Flag-Anwesha 2014</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/sticky-footer.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/bootstrap-theme.css" rel="stylesheet">
        <!--   <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
        <link href="css/jumbotron.css" rel="stylesheet">

    </head>
    <style type="text/css">

        /* Sticky footer styles
        -------------------------------------------------- */

        html,
        body {
            height: 100%;
            /* The html and body elements cannot have any padding or margin. */
        }

        /* Wrapper for page content to push down footer */
        #wrap {
            min-height: 100%;
            height: auto !important;
            height: 100%;
            /* Negative indent footer by it's height */
            margin: 0 auto -60px;
        }

        /* Set the fixed height of the footer here */
        #push,
        #footer {
            height: 60px;
        }
        #footer {
            background-color: black;
        }

        /* Lastly, apply responsive CSS fixes as necessary */
        @media (max-width: 767px) {
            #footer {
                margin-left: -20px;
                margin-right: -20px;
                padding-left: 20px;
                padding-right: 20px;
            }
        }



        /* Custom page CSS
        -------------------------------------------------- */
        /* Not required for template or sticky footer method. */

        .container {
            width: auto;
            max-width: 680px;
        }
        .container .credit {
            margin: 20px 0;
        }
    </style>
    <body  style=" background-color: #000" background="./Images/binary.jpg">

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="index.html">Capture The Flag</a>
                    <div class="nav-collapse collapse">
                        <ul class="nav">
                            <li ><a href="index.html">Welcome Page</a></li>
                            <li class="active"><a href="#">Registration</a></li>
                            <li><a href="http://2014.anwesha.info" target="_blank">Anwesha 2014</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div> </div>
        <p><p><p></p>
        <p><p><p></p>
        <p><p><p></p>
        <p><p><p></p>
        <p><p><p></p>
        <p><p><p></p>

        <div id="wrap">
            <!-- Main jumbotron for a primary marketing message or call to action -->

            <div class="jumbotron"  style=""   >
                <div class="container">
                    <fieldset class="well the-fieldset" style=" background-color: black">
                        <center>          <h2 class="greentext" style="color: green">Register Here</h2>  </center>  </fieldset>
                </div>
            </div>
            <div>
                <form  action="Registration" method="post" style="">
                    <center>  
                        <fieldset class="the-fieldset">
                            <input type="text" placeholder="Anwesha ID" name="Aid"/><br/>
                            <input type="password" placeholder="Password" name="Passwd"/><br/>
                            <input type="text" placeholder="Enter Your Name" name="Name"/><br/>
                            <input type="text" placeholder="Enter Your College Name" name="clg"/><br/>
                            <input type="email" placeholder="Enter Your Email Address" name="email"/><br/>
                            <input type="number" placeholder="Enter Your Contact Number" maxlength="10" name="contact"/><br/>

                            <button class="btn btn-success" align="left" type="submit">Submit</button>     
                            <button class="btn" align="left" type="reset">Reset</button>
                        </fieldset>
                    </center>
                </form>
                <%
                    try {

                        String prob = request.getParameter("prob");
                        if (prob.equals("incomplete")) {
                            out.print("<div class=" + "\"alert alert-error\"" + "><button type=" + "button" + " class=" + "close" + " data-dismiss=" + "alert" + ">&times;</button><h4>Alert!!!! Registartion not done.</h4>One or more entry was left bank. Please Re-enter the data.</div>");
                        } else if (prob.equals("length")) {
                            out.print("<div class=" + "\"alert alert-error\"" + "><button type=" + "button" + " class=" + "close" + " data-dismiss=" + "alert" + ">&times;</button><h4>Alert!!!! Data Insertion length Exceed.</h4>One or more entry has more characters than allowed. Please fill data carefully</div>");
                        } else if (prob.equals("idExist")) {
                            out.print("<div class=" + "\"alert alert-error\"" + "><button type=" + "button" + " class=" + "close" + " data-dismiss=" + "alert" + ">&times;</button><h4>Alert!!!! Already Exist the entered Anwesha ID</h4>Please fill data carefully. In case of problem,Plz contact Nishant Gandhi: 8292310761</div>");
                        }

                    } catch (Exception e) {
                    }
                %>    
            </div>
        </div>

        <!-- /container -->
        <div id="footer">
            <hr>
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <img href="#" src="./Images/anwesha.jpg" height="40"  width="30">
                        </td>
                        <td>
                            <p class="greentext" style="font-size: 20; font-weight: bold">&copy; Anwesha 2014,IIT Patna</p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <!--  <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script> -->
        <script src="css/bootstrap.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <!--  <script src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
        <!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
    </body>
</html>