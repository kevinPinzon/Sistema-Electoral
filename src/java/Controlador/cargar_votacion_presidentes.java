/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Elector;
import Modelos.Mesa_Electoral;
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
@WebServlet(name = "cargar_votacion_presidentes", urlPatterns = {"/cargar_votacion_presidentes"})
public class cargar_votacion_presidentes extends HttpServlet {

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
            List<Municipio> list_muni = Municipio.getAllMunicipios();
            Elector elector = (Elector)session.getAttribute("user_current");
            Mesa_Electoral mesa_electoral = Mesa_Electoral.getMesa_Electoral(elector.getId_me(),list_muni);
            
            session.setAttribute("mesa_electoral_current", mesa_electoral);

            List<Partido_politico> list_partidos = Partido_politico.getAllPartidosp();
            session.setAttribute("list_partidos", list_partidos);
            
            if (elector.getEstado() == 1 || elector.getEstado() > 4) {
                request.getRequestDispatcher("votacion_presidentes.jsp").forward(request, response);
            }else if (elector.getEstado()== 3) {
                request.getRequestDispatcher("cargar_votacion_alcaldes").forward(request, response);
            }else if (elector.getEstado()== 4) {
                request.getRequestDispatcher("cargar_votacion_diputados").forward(request, response);
            }
            
            List<Candidato_pp> list_presidentes = Candidato_pp.getCandidatos_por_posicion(1,0,0);
            List<Papeleta> presidentes_papeleta = Papeleta.getAllPresidentes(1);
            
            List<Candidato_pp> presidenes_pre_seleccionados = new ArrayList<Candidato_pp>();
            
            for (Papeleta presidente_papeleta : presidentes_papeleta) {
                for (Candidato_pp candidato_current : list_presidentes) {
                    if (candidato_current.getId() == presidente_papeleta.getId_candidato()) {
                        candidato_current.setPosicion(presidente_papeleta.getPosicion());
                        presidenes_pre_seleccionados.add(candidato_current);
                    }   
                }
            }
            
            for (Candidato_pp candidato_current : presidenes_pre_seleccionados) {
                for (Partido_politico partido_current : list_partidos) {
                    if (candidato_current.getPartido_id() == partido_current.getId()) {
                        candidato_current.setPartido_nombre(partido_current.getNombre());
                        candidato_current.setImagen_partido(partido_current.getLogo());
                    }
                }
            }
            
            session.setAttribute("presidentes_planilla", presidenes_pre_seleccionados);
            request.getRequestDispatcher("votacion_presidentes.jsp").forward(request, response);
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
