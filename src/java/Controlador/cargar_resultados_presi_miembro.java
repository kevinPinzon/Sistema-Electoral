/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Conteo;
import Modelos.Mesa_Electoral;
import Modelos.Miembro;
import Modelos.Municipio;
import Modelos.Papeleta;
import Modelos.Partido_politico;
import Modelos.Resultado;
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
@WebServlet(name = "cargar_resultados_presi_miembro", urlPatterns = {"/cargar_resultados_presi_miembro"})
public class cargar_resultados_presi_miembro extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
    
            HttpSession session = request.getSession();
            
            Miembro miembro = (Miembro) session.getAttribute("user_current");
            List<Municipio> list_muni = Municipio.getAllMunicipios();
            Mesa_Electoral mesa_electoral = Mesa_Electoral.getMesa_Electoral(miembro.getId_mesa(),list_muni);
            session.setAttribute("mesa_electora_current", mesa_electoral);
            
            if (mesa_electoral.getEstado() != 3) {
                request.getRequestDispatcher("resultados_presidente_miembro.jsp").forward(request, response);
            }
            
            Resultado resultados_presidente = Resultado.buscar_resultado(mesa_electoral.getId(),1,0,0);
            List<Conteo> conteos = Conteo.getCuentas(resultados_presidente.getId());

            List<Candidato_pp> list_presidentes = Candidato_pp.getCandidatos_por_posicion(1,0,0);
            List<Papeleta> presidentes_papeleta = Papeleta.getAllPresidentes(1);
            
            List<Candidato_pp> presidenes_planilla = new ArrayList<Candidato_pp>();
            
            for (Papeleta presidente_papeleta : presidentes_papeleta) {
                for (Candidato_pp candidato_current : list_presidentes) {
                    if (candidato_current.getId() == presidente_papeleta.getId_candidato()) {
                        candidato_current.setPosicion(presidente_papeleta.getPosicion());
                        presidenes_planilla.add(candidato_current);
                    }   
                }
            }
            
            List<Partido_politico> list_partidos = Partido_politico.getAllPartidosp();
            session.setAttribute("list_partidos", list_partidos);
            
            for (Candidato_pp candidato_current : presidenes_planilla) {
                for (Partido_politico partido_current : list_partidos) {
                    if (candidato_current.getPartido_id() == partido_current.getId()) {
                        candidato_current.setPartido_nombre(partido_current.getNombre());
                        candidato_current.setImagen_partido(partido_current.getLogo());
                    }
                }
            }
            
            for (Candidato_pp candidato_current : presidenes_planilla) {
                for (Conteo conteo_current : conteos) {
                    if (conteo_current.getId_candidato() == candidato_current.getId()) {
                        candidato_current.setConteo_votos(conteo_current.getCuenta());
                    }
                }
            }
            
            session.setAttribute("presidentes_planilla_resultado", presidenes_planilla);
            request.getRequestDispatcher("resultados_presidente_miembro.jsp").forward(request, response);
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
