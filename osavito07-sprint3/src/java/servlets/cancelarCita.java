/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD;

/**
 *
 * @author D
 */
public class cancelarCita extends HttpServlet {
    
    private Connection con;
    private Statement set;
    private ResultSet rs2;
    private Statement set2;
    private ResultSet rs3;
    private Statement set3;
    String cad;
    
    @Override
    public void init(ServletConfig cfg) throws ServletException {
        con = BD.getConexion();
    }

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet cancelarCita</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cancelarCita at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        HttpSession s = req.getSession(true);
        
        String tis = (String) s.getAttribute("tis");
        String codCita = (String) req.getParameter("numCita");
        
        //Mira el numero de citas del paciente antes de borrar
        int contInicial = 0;
        try {
            set3 = con.createStatement();
            rs3 = set3.executeQuery("SELECT * FROM citas WHERE tis='" + tis + "'");
            while(rs3.next()){
                contInicial++;
            }
            rs3.close();
            set3.close();
        } catch (SQLException ex1) {}
        
        //Intenta borrar
        try {
            set = con.createStatement();
            set.executeUpdate("DELETE FROM citas WHERE tis='" + tis + "' AND codCita='" + codCita +"' ");
            set.close();   
        } catch (SQLException ex1) {}
        
        //Mira el numero de citas del paciente despues de borrar
        int contFinal = 0;
        try {
            set2 = con.createStatement();
            rs2 = set2.executeQuery("SELECT * FROM citas WHERE tis='" + tis + "'");
            while(rs2.next()){
                contFinal++;
            }
            rs2.close();
            set2.close();
        } catch (SQLException ex1) {}
        
        //Si habian mas citas antes que despues, entonces el numCita es correcto y la cita se ha borrado
        if(contInicial > contFinal)
            res.sendRedirect("cancelarCitaOK.jsp");
        else
            res.sendRedirect("cancelarCitaERROR.jsp");
 
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
