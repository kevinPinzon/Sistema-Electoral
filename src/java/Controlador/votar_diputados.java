/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Conteo;
import Modelos.Departamento;
import Modelos.Elector;
import Modelos.Mesa_Electoral;
import Modelos.Municipio;
import Modelos.Resultado;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "votar_diputados", urlPatterns = {"/votar_diputados"})
public class votar_diputados extends HttpServlet {

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
            
            List<Departamento> list_dep = Departamento.getAllDepartamentos();
            List<Municipio> list_muni = Municipio.getAllMunicipios();
            Municipio municipio = new Municipio();
            Departamento departamento = new Departamento();
            
            for (Municipio municipio_current : list_muni) {
                    if (municipio_current.getId() == mesa_electoral.getId_municipio()) {
                        municipio = municipio_current;
                    }
            }
            
            for (Departamento departament_current : list_dep) {
                if (departament_current.getId() == municipio.getId_dep()) {
                    departamento = departament_current;
                }
            }
            
            Resultado resultado = Resultado.buscar_resultado(mesa_electoral.getId(),3,departamento.getId(),0);
            String diputados_id[] = request.getParameterValues("diputados");
            if (diputados_id != null && diputados_id.length != 0) {
                if (resultado.getId() != 0) {
                        for (String diputado_id : diputados_id) {
                            Conteo conteo = Conteo.buscar_conteo(resultado.getId(),Integer.parseInt(diputado_id));
                            if (conteo.getId() != 0) {
                                Conteo.sumar_voto(conteo.getId(),conteo.getCuenta()+1);
                            }else{
                                Conteo.insertar(ThreadLocalRandom.current().nextInt(0,9999),resultado.getId(),Integer.parseInt(diputado_id));
                            }
                        }
                }else{
                    int id_temp = ThreadLocalRandom.current().nextInt(0,9999);
                    Resultado.insertar(id_temp,mesa_electoral.getId(),3,departamento.getId(),0);
                    for (String diputado_id : diputados_id) {
                        Conteo.insertar(ThreadLocalRandom.current().nextInt(0,9999),id_temp,Integer.parseInt(diputado_id));    
                    }
                }
            }
            
            Elector elector = (Elector)session.getAttribute("user_current");
            Elector.registar_voto(elector.getId(),5);
            elector.setEstado(5);
            session.setAttribute("user_current", elector);
            request.getRequestDispatcher("home_elector.jsp").forward(request, response);
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
