/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Papeleta;
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
@WebServlet(name = "remover_candidato_papeleta", urlPatterns = {"/remover_candidato_papeleta"})
public class remover_candidato_papeleta extends HttpServlet {

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
            int candidato_id = Integer.parseInt(request.getParameter("candidato_id"));
            int cargo = Integer.parseInt(request.getParameter("cargo"));
            
            if (cargo == 1) {//presidentes
                List<Candidato_pp> list_presidentes = (ArrayList<Candidato_pp>) session.getAttribute("candidatos_presidenciales");
                List<Candidato_pp> presidentes_selecciados = (ArrayList<Candidato_pp>) session.getAttribute("presidenciales_seleccionados");

                int posicion = 1;
                
                Papeleta.delete(candidato_id);
                
                List<Candidato_pp> temp = new ArrayList<Candidato_pp>();
                for (Candidato_pp candidato_current : presidentes_selecciados) {
                    if (candidato_current.getId() != candidato_id) {
                        temp.add(candidato_current);
                        Papeleta.update(candidato_current.getId(), posicion-1);
                        candidato_current.setPosicion(posicion);
                        posicion++;
                    }
                }
                for (Candidato_pp presis : list_presidentes) {
                    if (presis.getId() == candidato_id) {
                        presis.setShow(true);
                    }
                }
                presidentes_selecciados = temp;
                
                session.setAttribute("candidatos_presidenciales", list_presidentes);
                session.setAttribute("presidenciales_seleccionados", presidentes_selecciados);
                request.getRequestDispatcher("diseñar_papeleta_presidentes.jsp").include(request, response);
            }else if(cargo == 2) {
                
            }else if(cargo == 3) {
            
                //papeleta.insertar(id,candidato_id,cargo,posicion);    
            }
            
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
