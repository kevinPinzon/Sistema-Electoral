/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Conteo;
import Modelos.Elector;
import Modelos.Mesa_Electoral;
import Modelos.Resultado;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "votar_alcalde", urlPatterns = {"/votar_alcalde"})
public class votar_alcalde extends HttpServlet {

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
            
            HttpSession session = request.getSession();
            Mesa_Electoral mesa_electoral = (Mesa_Electoral)session.getAttribute("mesa_electoral_current");
            int alcalde_id = Integer.parseInt(request.getParameter("alcalde"));
            
            Resultado resultado = Resultado.buscar_resultado(mesa_electoral.getId(),2,0,mesa_electoral.getId_municipio());

            if (resultado.getId() != 0) {
                Conteo conteo = Conteo.buscar_conteo(resultado.getId(),alcalde_id);
                if (conteo.getId() != 0) {
                    Conteo.sumar_voto(conteo.getId(),conteo.getCuenta()+1);
                }else{
                    Conteo.insertar(ThreadLocalRandom.current().nextInt(0,9999),resultado.getId(),alcalde_id);
                }
            }else{
                int id_temp = ThreadLocalRandom.current().nextInt(0,9999);
                Resultado.insertar(id_temp,mesa_electoral.getId(),2,0,mesa_electoral.getId_municipio());
                Conteo.insertar(ThreadLocalRandom.current().nextInt(0,9999),id_temp,alcalde_id);
            }
            Elector elector = (Elector)session.getAttribute("user_current");
            Elector.registar_voto(elector.getId(),4);
            elector.setEstado(4);
            session.setAttribute("user_current", elector);
            request.getRequestDispatcher("cargar_votacion_diputados").forward(request, response);
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
