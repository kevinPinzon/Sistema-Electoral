/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Miembro;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.ThreadLocalRandom;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author alex
 */
@WebServlet(name = "agregar_miembro", urlPatterns = {"/agregar_miembro"})
public class agregar_miembro extends HttpServlet {

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
            
            int correlativo = Integer.parseInt(request.getParameter("id_mm"));
            String nombre = request.getParameter("nombre_mm");
            String pass = request.getParameter("pass");
            int cargo = Integer.parseInt(request.getParameter("cargo"));
            int me_id = Integer.parseInt(request.getParameter("me_id"));       
            
            String id_cadena = me_id+""+cargo+""+correlativo+ThreadLocalRandom.current().nextInt(0,9);
            int id = Integer.parseInt(id_cadena);
            Miembro miembro = new Miembro();
            String insertar = miembro.insertar(id,pass,nombre,me_id,cargo);
            
            if (insertar.equals("insert")) {
                out.print("<script>alert('Nuevo Miembro agregado Exitosamente');</script>");
            }else{
                out.print("<script>alert('Intente mas tarde...');</script>");
                out.print("<script>console.log('"+insertar+"');</script>");
            }
            
            request.getRequestDispatcher("cargar_mesas_electorales").include(request, response);
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
        processRequest(request, response);
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
