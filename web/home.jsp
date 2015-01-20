<%-- 
    Document   : index
    Created on : Jan 27, 2014, 9:54:46 AM
    Author     : nishant
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CTF 14 Home</title>
        <link rel="shortcut icon" href="./Images/favicon.ico">
        <link href="css/jumbotron.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/sticky-footer.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/bootstrap-theme.css" rel="stylesheet">
        <!--  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
        <link href="css/jumbotron.css" rel="stylesheet">
    </head>
    <%
        HttpSession ses = request.getSession(true);
  //  if(ses.getAttribute("uname")==null)
        //  Object o = request.getAttribute("error")  
//if(null == x){  
        // x = "";  
//}
//String error = o.toString(); 
        //  if(ses.getAttribute("uname")==null)
        // if(path.equals(null))
        //   response.sendRedirect("index.html");
    %>
    <style type="text/css">

        /* Sticky footer styles
        -------------------------------------------------- */

        html,
        body {
            height: 100%;
            background:url('./Images/mbsmall.jpg') no-repeat center center;
            /* min-height:100%; */
            min-width:100%;
            background-size: cover;

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
    <body class="mb" >
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
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="http://2014.anwesha.info" target="_blank">Anwesha 2014</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div> </div>
            <%
                //total=problem solved
                //score=total score
                //uname=aid
                int repeat;
                repeat = -1;
                String problem_page = null;
                String ans_db = null;
                String ans = null;
                int problem_no = 0;

                try {
                    if (!(request.getParameter("flag") == null)) {

                        ans = request.getParameter("flag");
                    }

                    problem_no = Integer.parseInt(ses.getAttribute("total").toString()); //counted by zero
            /*
                     if(Integer.parseInt(ses.getAttribute("total").toString())<=15)
                     {
                     response.sendRedirect("completed.jsp");
                     }
                     */
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/anwesha_ctf15", "ctf", "");
                    PreparedStatement problemQ = cn.prepareCall("select * from answers where Pid=?");

                    if (problem_no == 0 && ans == null) {
                        problemQ.setInt(1, problem_no);
                        ResultSet rs = problemQ.executeQuery();
                        rs.first();
                        problem_page = rs.getString("Ppage");

                    } else if (problem_no > 0 && (ans == null)) {
                        PreparedStatement totalrows = cn.prepareCall("select * from answers");
                        ResultSet rstr = totalrows.executeQuery();
                        rstr.last();
                        int totaltr = rstr.getRow();
                        if (Integer.parseInt(ses.getAttribute("total").toString()) >= 11) {
                            response.sendRedirect("completed.jsp");
                        }
                        PreparedStatement stmtPage2 = cn.prepareCall("select * from answers where Pid=?");
                        int ppageid = Integer.parseInt(ses.getAttribute("total").toString());
                        out.print(problem_no);
                        stmtPage2.setInt(1, problem_no);
                        ResultSet rsstmtpage = stmtPage2.executeQuery();
                        rsstmtpage.first();
                        problem_page = rsstmtpage.getString("Ppage");

                    } else if (!(ans == null)) {

                        problemQ.setInt(1, problem_no);
                        ResultSet rs = problemQ.executeQuery();
                        rs.first();
                        ans_db = rs.getString("Panswer");

                        if (ans.equals(ans_db)) {
                            //update q? to 1
                            String query = "update problems set " + "p" + String.valueOf(++problem_no) + "=? where Id=?";
                            PreparedStatement ansser = cn.prepareCall(query);
                            // ansser.setString(1, "p"+String.valueOf(++problem_no)); //database problem start with 1
                            ansser.setInt(1, 1);
                            ansser.setString(2, ses.getAttribute("uname").toString());
                            ansser.execute();

                            //no of problems solved
                            ses.setAttribute("total", String.valueOf(problem_no));
                            //set the score
                            int previous_score = 0;
                            int score_gained = 0;
                            score_gained = rs.getInt("Ppoint");
                            previous_score = Integer.parseInt(ses.getAttribute("score").toString());
                            int total;
                            total = score_gained + previous_score;
                            ses.setAttribute("score", String.valueOf(total));
                            PreparedStatement totalscoreupdate = cn.prepareCall("update problems set total=? where Id=?");
                            totalscoreupdate.setString(2, ses.getAttribute("uname").toString());
                            totalscoreupdate.setInt(1, total);
                            totalscoreupdate.execute();
                            totalscoreupdate.close();
                            //for page
                            PreparedStatement stmtPage = cn.prepareCall("select * from answers where Pid=?");
                            int ppageid = Integer.parseInt(ses.getAttribute("total").toString());
                            out.print(problem_no);
                            stmtPage.setInt(1, problem_no);
                            ResultSet rsstmtpage = stmtPage.executeQuery();
                            rsstmtpage.first();
                            problem_page = rsstmtpage.getString("Ppage");
                            ///for checking limit
                            PreparedStatement totalrows = cn.prepareCall("select * from answers");
                            ResultSet rstr = totalrows.executeQuery();
                            rstr.last();
                            int totaltr = rstr.getRow();
                            if (Integer.parseInt(ses.getAttribute("total").toString()) >= 11) {
                                response.sendRedirect("completed.jsp");
                            }

                        } else {

                            //for page
                            PreparedStatement stmtPage1 = cn.prepareCall("select * from answers where Pid=?");
                            int ppageid = Integer.parseInt(ses.getAttribute("total").toString());
                            out.print(problem_no);
                            stmtPage1.setInt(1, problem_no);
                            ResultSet rsstmtpage = stmtPage1.executeQuery();
                            rsstmtpage.first();
                            problem_page = rsstmtpage.getString("Ppage");

                            repeat = 1;

                        }

                    }

                } catch (Exception e) {
                    response.sendRedirect("index.html");
                }
            %>      
        <div id="wrap">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span2" style=" background-color: black">
                        <!--Sidebar content-->

                        <span class="label label-success">Anwesha ID:</span><span class="label label-important"><%out.print(ses.getAttribute("uname")); %></span><br/>
                        <span class="label label-success">Score:</span><span class="label label-important"><% out.print(ses.getAttribute("score")); %></span><br/>
                        <span class="label label-success">Problem Solved:</span><span class="label label-important"><% out.print(ses.getAttribute("total")); %></span><br/>
                        <br/>
                        <center><h4 class="greentext" style="color: green">Problems:</h4></center><br/>
                       <!-- <span class="label" style=" font-size: 14pt">Problem:</span><span class="label label-success"><% //out.print(Integer.parseInt(ses.getAttribute("total").toString())+1); %></span><br/> -->
                        <%

                            int i = 0, j = 1;
                            String temp;
                            temp = ses.getAttribute("total").toString();

                            //  i=(Integer.parseInt(ses.getAttribute("total").toString()))+1;
                            i = Integer.parseInt(temp);
                            i++;
                            while (j <= i) {
                                // out.print("<div class="+"jumbotron"+">");
                                out.print("<center><table border=\"1px solid #e3e3e3>\"");
                                if (j < 10) {
                                    out.print("<tr><td class=\"greentext1\"><center>Problem 0" + j + "</center></td></tr>");
                                } else {
                                    out.print("<tr><td class=\"greentext1\"><center>Problem " + j + "</center></td></tr>");
                                }
                                //  out.print("<fieldset class="+"fieldset"+" style="+" \" border: 1px solid #e3e3e3;\""+">");
                                // out.print("<center><h6 class="+"greentext"+" style="+"\"color: green\""+">Problem "+j+"</h6></center>");
                                //  out.print("</fieldset>");        
                                //  out.print("</div>");
                                out.print("</table></center>");
                                j++;
                            }
                        %>
                    </div>
                    <div class="span10" >
                        <!--Body content-->

                        <div class="jumbotron"  style=""   >
                            <div class="container"> 
                                <fieldset class="well the-fieldset" style=" background-color: black" >
                                    <center><h2 class="greentext" style="color: green">CTF 14</h2></center>
                                    <center><h4 class="greentext" style="color: green">Welcome To Capture The Flag</h4></center>
                                    <center><h2 class="greentext" style="color: green">Problem <% out.print(Integer.parseInt(ses.getAttribute("total").toString()) + 1); %></h2></center>
                                </fieldset>
                            </div>
                        </div>
                        <br/><br/>
                        <form  action="#" method="post">
                            <center>  
                                <fieldset class="the-fieldset">
                                    <input type="text" name="flag" placeholder="Enter The Flag"/><br/> 
                                    <button class="btn btn-success" align="left" type="submit" name="problemsubmit">Submit</button>     
                                </fieldset>
                            </center>
                        </form>

                        <div class="jumbotron"  style=""   >
                            <div class="container">
                                <fieldset class="well the-fieldset" style=" background-color: black">
                                    <center><a class="greentext" style="color: green" href="problems/<%  out.print(problem_page); %>" target="_blank">Click Here For Flag</a></center>
                                    <center><h6 class="greentext" style="color: green">Solve this problem and submit the Flag to unlock next problem.</h6></center>
                                        <%
                                            if (repeat == 1) {
                                                out.print("<center><h6  style=\"color: red\">Wrong Flag.Try Again</h6></center>");
                                            }
                                        %>
                                </fieldset>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
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
    </body>
</html>
