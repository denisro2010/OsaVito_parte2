/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class asignarCita extends HttpServlet {

    private Connection con;
    private ResultSet rs;
    private ResultSet rs2;
    private Statement set;
    private Statement set2;
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
            out.println("<title>Servlet asignarCita</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet asignarCita at " + request.getContextPath() + "</h1>");
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

        boolean sePuede = true;

        String tipoSanitario = (String) req.getParameter("tiposanitario");
        s.setAttribute("tipoSanitario", tipoSanitario);

        String fechaCita = (String) req.getParameter("fechaCita");
        if (fechaCita != null) {
            s.setAttribute("fechaCita", fechaCita);
        }

        String horaCita = (String) req.getParameter("horaCita");
        if (horaCita != null) {
            s.setAttribute("horaCita", horaCita);
        }

        String tipoTabla;
        String numColegiado = null;
        String tis = (String) s.getAttribute("tis");

        String fcha;
        String hra;
        //Se puede poner la cita?
        try {
            set2 = con.createStatement();
            rs2 = set2.executeQuery(" SELECT tis, fecha, hora FROM citas WHERE tis='" + tis + "' ");
            while (rs2.next()) {
                fcha = rs2.getString("fecha");
                hra = rs2.getString("hora");

                if (fechaCita.equals(fcha) || horaCita.equals(hra)) {
                    sePuede = false;
                }
            }
            rs2.close();
            set2.close();
        } catch (SQLException ex1) {
            System.out.println("Error" + ex1);
        }

        //Recuperar el numColegiado del sanitario que se ha elegido
        try {
            set2 = con.createStatement();
            rs2 = set2.executeQuery("SELECT numColegiado, tipoSanitario FROM sanitarios WHERE numColegiado IN(SELECT numColegiado FROM sanitariosypacientes WHERE TIS='" + tis + "')");
            while (rs2.next()) {
                tipoTabla = rs2.getString("tipoSanitario");

                if (tipoTabla.equals(tipoSanitario)) {
                    numColegiado = rs2.getString("numColegiado");
                }
            }
            rs2.close();
            set2.close();
        } catch (SQLException ex1) {
            System.out.println("Error" + ex1);
        }

        s.setAttribute("numColegiado", numColegiado);

        Double codD = Math.floor((Math.random() * 1000000) + 1);
        int cod = codD.intValue();
        String codCita = String.valueOf(cod);
        s.setAttribute("codCita", codCita);

        try {
            if (sePuede) {
                set = con.createStatement();
                set.executeUpdate("INSERT INTO citas(tis, numColegiado, fecha, hora, codCita) VALUES (" + tis + ", " + numColegiado + ", '" + fechaCita + "', '" + horaCita + "', " + codCita + ")");
                set.close();

                res.sendRedirect("asignarCitaOK.jsp");
            } else {
                res.sendRedirect("asignarCitaERROR.jsp");
            }

        } catch (SQLException ex2) { //Si el sanitario, la fecha y la hora coinciden o si coges cita con un matron siendo hombre
            res.sendRedirect("asignarCitaERROR.jsp");
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
