/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Conteo;
import Modelos.Elector;
import Modelos.Resultado;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "votar_presidente", urlPatterns = {"/votar_presidente"})
public class votar_presidente extends HttpServlet {

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

           /* out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet votar_presidente</title>");            
            out.println("</head>");
            out.println("<body>");            
            out.println("<h1>me_id: " + me_id + "</h1>");
            out.println("<h1>presi_id: " + presi_id + "</h1>");
            out.println("</body>");
            out.println("</html>");*/
           
            int me_id = Integer.parseInt(request.getParameter("me_id"));
            int presi_id = Integer.parseInt(request.getParameter("presidente"));
            
            Resultado resultado = Resultado.buscar_resultado(me_id,1,0,0);
            if (resultado.getId() != 0) {
                Conteo conteo = Conteo.buscar_conteo(resultado.getId(),presi_id);
                if (conteo.getId() != 0) {
                    Conteo.sumar_voto(conteo.getId(),conteo.getCuenta()+1);
                }else{
                    Conteo.insertar(ThreadLocalRandom.current().nextInt(0,9999),resultado.getId(),presi_id);
                }
            }else{
                int id_temp = ThreadLocalRandom.current().nextInt(0,9999);
                Resultado.insertar(id_temp,me_id,1,0,0);
                Conteo.insertar(ThreadLocalRandom.current().nextInt(0,9999),id_temp,presi_id);
            }
            
            HttpSession session = request.getSession();
            Elector elector = (Elector)session.getAttribute("user_current");
            Elector.registar_voto(elector.getId(),3);
            elector.setEstado(3);
            session.setAttribute("user_current", elector);
            request.getRequestDispatcher("votacion_alcaldes.jsp").forward(request, response);
            
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
