/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Municipio;
import Modelos.Papeleta;
import Modelos.Partido_politico;
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
@WebServlet(name = "cargar_alcaldes", urlPatterns = {"/cargar_alcaldes"})
public class cargar_alcaldes extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            
            List<Partido_politico> list_partidos = (ArrayList<Partido_politico>) session.getAttribute("list_partidos");
            List<Municipio> list_muni = Municipio.getAllMunicipios();
            session.setAttribute("list_muni", list_muni);
            
            List<Candidato_pp> list_alcaldes = Candidato_pp.getCandidatos_por_posicion(2,list_muni.get(0).getId(),0);
            List<Papeleta> alcaldes_papeleta = Papeleta.getAllAlcaldes(2,list_muni.get(0).getId());
            
            List<Candidato_pp> alcaldes_pre_seleccionados = new ArrayList<Candidato_pp>();
            
            for (Papeleta alcalde_papeleta : alcaldes_papeleta) {
                for (Candidato_pp candidato_current : list_alcaldes) {
                    if (candidato_current.getId() == alcalde_papeleta.getId_candidato()) {
                        candidato_current.setPosicion(alcalde_papeleta.getPosicion());
                        candidato_current.setShow(false);
                        alcaldes_pre_seleccionados.add(candidato_current);
                    }   
                }
            }
            
            for (Candidato_pp candidato_current : list_alcaldes) {
                for (Partido_politico partido_current : list_partidos) {
                    if (candidato_current.getPartido_id() == partido_current.getId()) {
                     candidato_current.setPartido_nombre(partido_current.getNombre());   
                    }
                }
            }

            session.setAttribute("municipio_name", list_muni.get(0).getNombre());    
            session.setAttribute("candidatos_alcaldes", list_alcaldes);
            session.setAttribute("alcaldes_seleccionados",alcaldes_pre_seleccionados);
            
            request.getRequestDispatcher("diseñar_papeleta_alcaldes.jsp").include(request, response);
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
