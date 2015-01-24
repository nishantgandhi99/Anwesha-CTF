/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package CTFCode;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nishant
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String uname = null;
        String pass = null;

        if (!(request.getParameter("user") == null || request.getParameter("pass") == null)) {
            uname = request.getParameter("user");
            pass = request.getParameter("pass");
            System.out.println(uname+pass);

        } else {
            response.sendRedirect("index.html");
        }

        String plaintext = pass;
        MessageDigest m = MessageDigest.getInstance("MD5");
        m.reset();
        m.update(plaintext.getBytes());
        byte[] digest = m.digest();
        BigInteger bigInt = new BigInteger(1, digest);
        String hashtext = bigInt.toString(16);
// Now we need to zero pad it if you actually want the full 32 chars.
        while (hashtext.length() < 32) {
            hashtext = "0" + hashtext;
        }

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/anwesha_ctf15", "ctf", "");
        PreparedStatement ps = cn.prepareCall("select tname,pass from login where tname=? and pass=?");
        ps.setString(1, uname);
        ps.setString(2, hashtext);
        ResultSet rs = ps.executeQuery();
        int problemstotal;
        out.print(rs.isBeforeFirst());

        if (rs.first()) {

            HttpSession ses = request.getSession(true);
            ses.setAttribute("uname", rs.getString(1));

            PreparedStatement total = cn.prepareCall("select total from problems where Id=?");
            total.setString(1, uname);
            ResultSet rstotal = total.executeQuery();
            rstotal.first();
            ses.setAttribute("score", rstotal.getInt("total"));
            total = cn.prepareCall("select * from problems where Id=?");
            total.setString(1, uname);
            rstotal = total.executeQuery();
            rstotal.first();

            problemstotal = rstotal.getInt("p1") + rstotal.getInt("p2") + rstotal.getInt("p3") + rstotal.getInt("p4") + rstotal.getInt("p5") + rstotal.getInt("p6") + rstotal.getInt("p7") + rstotal.getInt("p8") + rstotal.getInt("p9") + rstotal.getInt("p10") + rstotal.getInt("p11") + rstotal.getInt("p12") + rstotal.getInt("p13") + rstotal.getInt("p14") + rstotal.getInt("p15");

            ses.setAttribute("total", String.valueOf(problemstotal));

            response.sendRedirect("home.jsp");
        } else {
 //     RequestDispatcher rd = request.getRequestDispatcher("studentdetail.jsp?login=nologin");
            // rd.forward(request, response);
            // request.sendRedirect("");
            response.sendRedirect("index.html");
        }

        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            try {
                processRequest(request, response);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            try {
                processRequest(request, response);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
