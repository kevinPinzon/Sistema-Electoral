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
@WebServlet(name = "agregar_candidato_papeleta", urlPatterns = {"/agregar_candidato_papeleta"})
public class agregar_candidato_papeleta extends HttpServlet {

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
            int id = ThreadLocalRandom.current().nextInt(0,9999);
            int candidato_id = Integer.parseInt(request.getParameter("candidato_id"));
            int cargo = Integer.parseInt(request.getParameter("cargo"));
            int posicion=0;
            
            if (cargo == 1) {//presidentes
                List<Candidato_pp>  list_presidentes = (ArrayList<Candidato_pp>) session.getAttribute("candidatos_presidenciales");
                List<Candidato_pp> presidentes_selecciados = (ArrayList<Candidato_pp>) session.getAttribute("presidenciales_seleccionados");
                posicion = presidentes_selecciados.size()+1;
                
                for (Candidato_pp candidato_current : list_presidentes) {
                    if (candidato_current.getId() == candidato_id) {
                        candidato_current.setPosicion(posicion);
                        candidato_current.setShow(false);
                        presidentes_selecciados.add(candidato_current);
                    }
                }
                
                session.setAttribute("candidatos_presidenciales", list_presidentes);
                session.setAttribute("presidenciales_seleccionados", presidentes_selecciados);
                Papeleta.insertar(id,candidato_id,cargo,posicion,0,0);
                request.getRequestDispatcher("diseñar_papeleta_presidentes.jsp").include(request, response);
                
            }else if(cargo == 2) {//alcalde                
                List<Candidato_pp> list_alcaldes = (ArrayList<Candidato_pp>) session.getAttribute("candidatos_alcaldes");
                List<Candidato_pp> alcaldes_seleccionados= (ArrayList<Candidato_pp>) session.getAttribute("alcaldes_seleccionados");
                posicion = alcaldes_seleccionados.size()+1;
                
                for (Candidato_pp candidato_current : list_alcaldes) {
                    if (candidato_current.getId() == candidato_id) {
                        candidato_current.setPosicion(posicion);
                        candidato_current.setShow(false);
                        alcaldes_seleccionados.add(candidato_current);
                    }
                }
                
                session.setAttribute("candidatos_alcaldes", list_alcaldes);
                session.setAttribute("alcaldes_seleccionados", alcaldes_seleccionados);
                Papeleta.insertar(id,candidato_id,cargo,posicion,Integer.parseInt(request.getParameter("muni")),0);
                request.getRequestDispatcher("diseñar_papeleta_alcaldes.jsp").include(request, response);
            }else if(cargo == 3) {
            
                
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
