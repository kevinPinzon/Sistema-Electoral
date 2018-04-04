/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Conteo;
import Modelos.Departamento;
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
@WebServlet(name = "cargar_resultados_diputados_miembro", urlPatterns = {"/cargar_resultados_diputados_miembro"})
public class cargar_resultados_diputados_miembro extends HttpServlet {

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
            
            Miembro miembro = (Miembro) session.getAttribute("user_current");
            
            List<Municipio> list_muni = Municipio.getAllMunicipios();

            Mesa_Electoral mesa_electoral = Mesa_Electoral.getMesa_Electoral(miembro.getId_mesa(),list_muni);
            session.setAttribute("mesa_electora_current", mesa_electoral);
            
            Municipio municipio = new Municipio();
            for (Municipio municipio_current : list_muni) {
                    if (municipio_current.getId() == mesa_electoral.getId_municipio()) {
                        municipio = municipio_current;
                    }
            }            
            List<Departamento> list_dep = Departamento.getAllDepartamentos();
            for (Departamento dep_current : list_dep) {
                    if (dep_current.getId() == municipio.getId_dep()) {
                        session.setAttribute("dep_name", dep_current.getNombre());
                    }
            }
            if (mesa_electoral.getEstado() != 3) {
                request.getRequestDispatcher("resultados_diputados_miembro.jsp").forward(request, response);
            }
            Resultado resultados_diputados = Resultado.buscar_resultado(mesa_electoral.getId(),3,municipio.getId_dep(),0);
            List<Conteo> conteos = Conteo.getCuentas(resultados_diputados.getId());
            
            List<Candidato_pp> list_dipus = Candidato_pp.getCandidatos_por_posicion(3,0,municipio.getId_dep());
            List<Papeleta> dipus_papeleta = Papeleta.getAllDiputado(3,municipio.getId_dep());
            
            List<Candidato_pp> dipus_pre_seleccionados = new ArrayList<Candidato_pp>();
            List<Partido_politico> list_partidos = Partido_politico.getAllPartidosp();
            
            for (Papeleta alcalde_papeleta : dipus_papeleta) {
                for (Candidato_pp candidato_current : list_dipus) {
                    if (candidato_current.getId() == alcalde_papeleta.getId_candidato()) {
                        candidato_current.setPosicion(alcalde_papeleta.getPosicion());
                        dipus_pre_seleccionados.add(candidato_current);
                    }   
                }
            }
            
            for (Candidato_pp candidato_current : dipus_pre_seleccionados) {
                for (Partido_politico partido_current : list_partidos) {
                    if (candidato_current.getPartido_id() == partido_current.getId()) {
                        candidato_current.setPartido_nombre(partido_current.getNombre());
                        candidato_current.setImagen_partido(partido_current.getLogo());
                    }
                }
            }
            
            for (Candidato_pp candidato_current : dipus_pre_seleccionados) {
                for (Conteo conteo_current : conteos) {
                    if (conteo_current.getId_candidato() == candidato_current.getId()) {
                        candidato_current.setConteo_votos(conteo_current.getCuenta());
                    }
                }
            }            

            session.setAttribute("diputados_planilla",dipus_pre_seleccionados);
            request.getRequestDispatcher("resultados_diputados_miembro.jsp").include(request, response);
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
