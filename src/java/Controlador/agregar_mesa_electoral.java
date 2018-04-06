/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Mesa_Electoral;
import Modelos.Municipio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author alex
 */
@WebServlet(name = "agregar_mesa_electoral", urlPatterns = {"/agregar_mesa_electoral"})
public class agregar_mesa_electoral extends HttpServlet {

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
            Mesa_Electoral me = new Mesa_Electoral();
            
            String lugar_nombre = request.getParameter("lugar_nombre");
            String lugar_descripcion = request.getParameter("lugar_descripcion");
            int correlativo = Integer.parseInt(request.getParameter("me_id"));
            int id_municipio = Integer.parseInt(request.getParameter("id_municipio"));
            
            String id_cadena = ""+correlativo+ThreadLocalRandom.current().nextInt(0,99);
            String insertar = me.insertar(Integer.parseInt(id_cadena),lugar_nombre,lugar_descripcion,id_municipio,"14.1042535","-87.1883147");
            
            if (insertar.equals("insert")) {
                out.print("<script>alert('Mesa Electoral Guardada Exitosamente');</script>");
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
