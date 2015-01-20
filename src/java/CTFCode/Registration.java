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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author nishant
 */
@WebServlet(name = "Registration", urlPatterns = {"/Registration"})
public class Registration extends HttpServlet {

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
            throws ServletException, IOException, NoSuchAlgorithmException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/anwesha_ctf15", "ctf", "");
        String tname = request.getParameter("tname");
        String pass = request.getParameter("pass");
        String aid1 = request.getParameter("aid1");
        String aid2 = request.getParameter("aid2");
        String aid3 = request.getParameter("aid3");
        String phone = request.getParameter("phone");
        String clg = request.getParameter("college");
        String email = request.getParameter("email");

        PreparedStatement ps = cn.prepareCall("select tname from user_info where tname=?");
        ps.setString(1, tname);
        ResultSet rs = ps.executeQuery();
        out.write("query executed");
        /*if (rs.first()) {
            response.sendRedirect("register.jsp?prob=idExist");
        } else {
            out.write("duplicate entry");
        }
        if (uid.length() > 10 || pass.length() > 20 || name.length() > 50 || name.length() > 50 || email.length() > 20 || phno.length() > 11) {
            response.sendRedirect("register.jsp?prob=length");
        }

        if (uid.isEmpty() || pass.isEmpty() || name.isEmpty() || clg.isEmpty() || email.isEmpty() || phno.isEmpty()) {
            response.sendRedirect("register.jsp?prob=incomplete");
        }*/
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

        PreparedStatement prst = cn.prepareCall("insert into user_info values(?,?,?,?,?,?,?)");
        prst.setString(1, tname);
        prst.setString(2, aid1);
        prst.setString(3, aid2);
        prst.setString(4, aid3);
        prst.setString(5, phone);
        prst.setString(6, clg);
        prst.setString(7, email);
        prst.execute();
        prst.close();
        PreparedStatement Auth = cn.prepareCall("insert into login values(?,?)");
        Auth.setString(1, tname);
        Auth.setString(2, hashtext);
        Auth.execute();
        Auth.close();
        PreparedStatement problem = cn.prepareCall("insert into user_track values(?,0,0,0,0,0,0,0,0,0,0)");
        problem.setString(1, tname);
        problem.execute();
        problem.close();
        cn.close();
        response.sendRedirect("index.html");

        try {
            /* TODO output your page here. You may use following sample code. */

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
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
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
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
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
