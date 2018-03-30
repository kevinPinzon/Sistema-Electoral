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
            //int id = ThreadLocalRandom.current().nextInt(0,9999);
            int candidato_id = Integer.parseInt(request.getParameter("candidato_id"));
            int cargo = Integer.parseInt(request.getParameter("cargo"));
            //Papeleta papeleta = new Papeleta();
            int posicion=0;
            if (cargo == 1) {//presidentes
                List<Candidato_pp> list_presidentes = new ArrayList<Candidato_pp>();
                List<Candidato_pp> presidentes_selecciados = new ArrayList<Candidato_pp>();            
                list_presidentes = (ArrayList<Candidato_pp>) session.getAttribute("candidatos_presidenciales");
                presidentes_selecciados = (ArrayList<Candidato_pp>) session.getAttribute("presidenciales_seleccionados");
                posicion = presidentes_selecciados.size()+1;
                
                /*out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet remover_candidato_papeleta</title>");            
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>candidato_id " + candidato_id + "</h1>");
                out.println("<h1>cargo " + cargo + "</h1>");
                out.println("<h1>list_presidentes.size " + list_presidentes.size() + "</h1>");
                out.println("<h1>presidentes_selecciados.size " + presidentes_selecciados.size() + "</h1>");
                out.println("<h3>Antes dell for..</h3>");*/
                int contador = 0;
                List<Candidato_pp> temp = new ArrayList<Candidato_pp>();
                for (Candidato_pp candidato_current : list_presidentes) {
                    if (candidato_current.getId() == candidato_id) {
                        /*out.println("<h4>contador " + contador + "</h4>");
                        out.println("<h2>candidato_current.getNombre() " + candidato_current.getNombre() + "</h2>");
                        out.println("<h2>candidato_current.getId() " + candidato_current.getId() + "</h2>");*/
                        candidato_current.setPosicion(posicion);
                        presidentes_selecciados.add(candidato_current);
                    }else{
                        temp.add(candidato_current);
                    }
                    contador++;
                }
                list_presidentes = temp;
                /*out.println("<h3>Despues del for..</h3>");
                out.println("</body>");
                out.println("</html>");*/
                
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
