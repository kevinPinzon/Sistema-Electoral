/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Conteo;
import Modelos.Departamento;
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
@WebServlet(name = "cargar_resultados_globales_diputados_magistrado", urlPatterns = {"/cargar_resultados_globales_diputados_magistrado"})
public class cargar_resultados_globales_diputados_magistrado extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            
            List<Partido_politico> list_partidos = Partido_politico.getAllPartidosp();
            List<Departamento> list_dep = Departamento.getAllDepartamentos();
            session.setAttribute("list_dep", list_dep);
            
            int id_dep;
            if (request.getParameter("dep") != null) {
                id_dep = Integer.parseInt(request.getParameter("dep"));
            }else{
                id_dep = list_dep.get(0).getId();
            }
            
            List<Candidato_pp> list_dipus = Candidato_pp.getCandidatos_por_posicion(3,0,id_dep);
            List<Papeleta> dipus_papeleta = Papeleta.getAllDiputado(3,id_dep);
            
            List<Candidato_pp> dipus_pre_seleccionados = new ArrayList<Candidato_pp>();
            
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
            for (Departamento dep_current : list_dep) {
                    if (dep_current.getId() == id_dep) {
                        session.setAttribute("dep_name", dep_current.getNombre());
                    }
            }

            List<Resultado> resultados_presidente = Resultado.buscar_resultado_por_cargo(3,id_dep,0);

            for (Resultado resultado_current : resultados_presidente) {
                List<Conteo> conteos = Conteo.getCuentas(resultado_current.getId());
                for (Conteo conteo_current : conteos) {
                    for (Candidato_pp candidato_current : dipus_pre_seleccionados) {
                        if (candidato_current.getId() == conteo_current.getId_candidato()) {
                            candidato_current.setConteo_votos(candidato_current.getConteo_votos() + conteo_current.getCuenta());
                        }
                    }
                }
            }

            session.setAttribute("resultados_gloables_diputados", dipus_pre_seleccionados);
            
            request.getRequestDispatcher("resultado_diputados_magistrado.jsp").forward(request, response);
            
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
