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
    private PrintWriter out;
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
        out= response.getWriter();
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/anwesha_ctf15", "ctf", "");
        String tname = request.getParameter("tname");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String aid1 = request.getParameter("aid1");
        String aid2 = request.getParameter("aid2");
        String aid3 = request.getParameter("aid3");
        String phone = request.getParameter("phone");
        String clg = request.getParameter("college");
        String email = request.getParameter("email");
        out.write("input testing\n");
        
        if(!checkInputs(cn,response,tname,pass,repass,aid1,aid2,aid3,phone,clg,email))
        {
            out.close();
            return;
        }
        
        out.write("Inserting Data\n");
        
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
        response.sendRedirect("index.jsp?info=done");

        try {
            /* TODO output your page here. You may use following sample code. */

        } finally {
            out.close();
        }
    }
    private boolean checkInputs(Connection cn,HttpServletResponse response,String tname,String pass,String repass,String aid1,String aid2,String aid3,String phone,String clg,String email) throws IOException, SQLException
    {
        if (tname.isEmpty() || pass.isEmpty() || aid1.isEmpty() || clg.isEmpty() || email.isEmpty() ) {
            out.write("incompleteForm\n");
            response.sendRedirect("index.jsp?prob=incomplete");
            return false;
        }
        
        if (!pass.equals(repass)) {
            out.write("passwordUnmatched\n");
            response.sendRedirect("index.jsp?prob=passUnMatch");
            return false;
        }
       
        if (tname.length() > 20 || pass.length() > 20 || aid1.length()>20||  email.length() > 50 || clg.length() > 50)
        {
            out.write("lengthShort\n");
            response.sendRedirect("index.jsp?prob=length");
            return false;
        }
        else if(((!aid2.isEmpty()) && aid2.length()>20) || ((!aid3.isEmpty()) && aid3.length()>20) )
        {
            out.write("lengthShort\n");
            response.sendRedirect("index.jsp?prob=length");
            return false;
        }
        if((!phone.isEmpty()))
        {
            if(phone.length()!=10)
            {
            out.write("phoneFormat\n");
            response.sendRedirect("index.jsp?prob=phone");
            return false;
            }
                  
        }    
        return checkDatabase(cn,response,tname,aid1,aid2,aid3,phone);
        
    }
    private boolean checkDatabase(Connection cn,HttpServletResponse response,String tname,String aid1,String aid2,String aid3,String phone) throws SQLException, IOException
    {
        PreparedStatement ps = cn.prepareCall("select tname from user_info where tname=?");
        ps.setString(1, tname);
        ResultSet rs = ps.executeQuery();
        if (rs.first()) {
            out.write("TeamNameExist");
            response.sendRedirect("index.jsp?prob=teamExist");
            
            return false;
        } 
        
        
        ps = cn.prepareCall("select member1,member2,member3 from user_info where member1=? OR member2=? OR member3=?");
        ps.setString(1, aid1);
        ps.setString(2, aid1);
        ps.setString(3, aid1);
        
        rs = ps.executeQuery();
        if (rs.first()) {
            out.write("Dupilicate Entry!");
            response.sendRedirect("index.jsp?prob=idExist&name="+aid1);
            return false;
        }
        
        if(!aid2.isEmpty())
        {
            
            ps = cn.prepareCall("select member1,member2,member3 from user_info where member1=? OR member2=? OR member3=?");
            ps.setString(1, aid2);      
            ps.setString(2, aid2);      
            ps.setString(3, aid2);      
            rs = ps.executeQuery();
            if (rs.first()) {
                out.write("Dupilicate Entry!");
                response.sendRedirect("index.jsp?prob=idExist&name=" + aid2);
                return false;
            }

        }
        
        if(!aid3.isEmpty())
        {
            
            ps = cn.prepareCall("select member1,member2,member3 from user_info where member1=? OR member2=? OR member3=?");
            ps.setString(1, aid3);      
            ps.setString(2, aid3);      
            ps.setString(3, aid3);      
            
            rs = ps.executeQuery();
            if (rs.first()) {
                out.write("Dupilicate Entry!");
                response.sendRedirect("index.jsp?prob=idExist&name=" + aid3);
                return false;
            }

        }
        
        if(!aid3.isEmpty())
        {
            
            ps = cn.prepareCall("select member1,member2,member3 from user_info where member1=? OR member2=? OR member3=?");
            ps.setString(1, aid3);      
            ps.setString(2, aid3);      
            ps.setString(3, aid3);      
            
            rs = ps.executeQuery();
            if (rs.first()) {
                out.write("Dupilicate Entry!");
                response.sendRedirect("index.jsp?prob=idExist&name=" + aid3);
                return false;
            }

        }
        
        return true;
        
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
