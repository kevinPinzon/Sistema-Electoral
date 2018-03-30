/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

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

/**
 *
 * @author alex
 */
@WebServlet(name = "editar_partidopolitico", urlPatterns = {"/editar_partidopolitico"})
public class editar_partidopolitico extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */            
            
            boolean insert=true;
            Partido_politico p = new Partido_politico();
            /*ArrayList<Partido_politico> list_partidos = (ArrayList<Partido_politico>)request.getAttribute("partidospoliticos");
            for (Partido_politico p2 : list_partidos) {
                if (request.getParameter("partidopolitico_nombre").equals(p2.getNombre()))
                    insert=false;
            }
            if (insert) {*/
                p.update(request.getParameter("partidopolitico_nombre"),Integer.parseInt(request.getParameter("partidopolitico_id")));
              /*  request.getRequestDispatcher("home_admin.jsp").include(request, response);
            }else{
                out.print("<script>alert('Ya existe un Partido Politico con este nombre');</script>");
                request.getRequestDispatcher("partidos_politicos.jsp").include(request, response);
            }*/
              out.print("<script>alert('Partido Politico Actualizado Exitosamente');</script>");
              request.getRequestDispatcher("Cargar_partidos_politicos").include(request, response);
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
