/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Candidato_pp;
import Modelos.Departamento;
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
@WebServlet(name = "cargar_diputado_papeleta", urlPatterns = {"/cargar_diputado_papeleta"})
public class cargar_diputado_papeleta extends HttpServlet {

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
            
            List<Partido_politico> list_partidos = (ArrayList<Partido_politico>) session.getAttribute("list_partidos");
            List<Departamento> list_dep = Departamento.getAllDepartamentos();
            session.setAttribute("list_dep", list_dep);
            session.setAttribute("dep_name", list_dep.get(0).getNombre());
            
            List<Candidato_pp> list_dipus = Candidato_pp.getCandidatos_por_posicion(3,0,list_dep.get(0).getId());
            List<Papeleta> dipus_papeleta = Papeleta.getAllDiputado(3,list_dep.get(0).getId());
            
            List<Candidato_pp> dipus_pre_seleccionados = new ArrayList<Candidato_pp>();
            
            for (Papeleta dipu_papeleta : dipus_papeleta) {
                for (Candidato_pp candidato_current : list_dipus) {
                    if (candidato_current.getId() == dipu_papeleta.getId_candidato()) {
                        candidato_current.setPosicion(dipu_papeleta.getPosicion());
                        candidato_current.setShow(false);
                        dipus_pre_seleccionados.add(candidato_current);
                    }   
                }
            }
            for (Candidato_pp candidato_current : list_dipus) {
                for (Partido_politico partido_current : list_partidos) {
                    if (candidato_current.getPartido_id() == partido_current.getId()) {
                     candidato_current.setPartido_nombre(partido_current.getNombre());   
                    }
                }
            }
            
            session.setAttribute("candidatos_dipu", list_dipus);
            session.setAttribute("dipu_seleccionados",dipus_pre_seleccionados);
            
            request.getRequestDispatcher("diseñar_papeleta_diputado.jsp").include(request, response);
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
