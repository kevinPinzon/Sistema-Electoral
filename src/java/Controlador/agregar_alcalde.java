/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Municipio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "agregar_alcalde", urlPatterns = {"/agregar_alcalde"})
public class agregar_alcalde extends HttpServlet {

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
            
            HttpSession session = request.getSession();
            List<Municipio> list_muni = (ArrayList<Municipio>) session.getAttribute("list_muni");
            
            int id = Integer.parseInt((String)session.getAttribute("id"));
            int id_pp = Integer.parseInt((String)session.getAttribute("id_pp"));
            int id_muni = Integer.parseInt((String)session.getAttribute("municipio"));
            int id_dep = 0;
            String nombre = (String)session.getAttribute("candidato_nombre");
            String imagen = (String)session.getAttribute("imagen");
            
            for (Municipio municipio_current : list_muni) {
                if (municipio_current.getId() == id_muni){
                    id_dep = municipio_current.getId_dep();                    
                }
            }
            Candidato_pp candidato = new Candidato_pp();
            String id_cadena = id+""+id_pp+""+2;
            id = Integer.parseInt(id_cadena);
            int insertar = candidato.insertar(id,id_pp,2,id_dep,id_muni,nombre,imagen);
            if (insertar > 0 ) {
                out.print("<script>alert('Alcalde Agregado Exitosamente');</script>");
            }else{
                out.print("<script>alert('Intente mas tarde...');</script>");
            }
            
            request.getRequestDispatcher("Cargar_partidos_politicos").include(request, response);

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
