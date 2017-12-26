
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD;


public class loginPaciente extends HttpServlet {

    
   private Connection con;
    private Statement set;
    private ResultSet rs;
    String cad;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        con = BD.getConexion();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = res.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginPaciente</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginPaciente at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
           HttpSession s = req.getSession(true);
           
           String tis = (String) req.getParameter("numTIS");
           s.setAttribute("tis", tis);
           String fechaNacPac = (String) req.getParameter("fecha");
           s.setAttribute("fechaNacPac", fechaNacPac);
           
           if(comprobarUsuario(tis, fechaNacPac)){
            res.sendRedirect("asignarOCancelar.html");
           }
           else{
           res.sendRedirect("loginPacienteError.jsp");
           }
        
    }
    
    
     public boolean comprobarUsuario(String tis, String fechaNacPac) {
         
      boolean st =false;
      
      try{

         PreparedStatement ps =con.prepareStatement("select * from pacientes where tis=? and fechaNac=?");
         ps.setString(1, tis);
         ps.setString(2, fechaNacPac);
         ResultSet rs =ps.executeQuery();
         st = rs.next();
        
      }catch(Exception e)
      {
          e.printStackTrace();
      }
         return st;                 
  }   
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
