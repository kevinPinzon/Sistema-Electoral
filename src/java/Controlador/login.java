/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelos.Admin;
import Modelos.Miembro;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
            
            HttpSession session = request.getSession();
            int role = Integer.parseInt(request.getParameter("role"));
            String user_id = request.getParameter("user_id");
            String user_pass = request.getParameter("pass");
            switch(role){
            case 4:
                Miembro miembro = new Miembro();
                miembro = miembro.login_miembro(Integer.parseInt(user_id),user_pass);
                if (miembro.getId() == 0 || miembro.getPass().equals(".")) {
                    out.print("<script>alert('"+miembro.getNombre()+"');</script>");
                    out.print("<script>console.log('"+miembro.getNombre()+"');</script>");
                    request.getRequestDispatcher("index.jsp").forward(request, response);   
                }else{
                 session.setAttribute("user_current", miembro);
                request.getRequestDispatcher("home_miembro_mesa.jsp").forward(request, response);   
                }
                break;
            case 3:
                Admin admin = new Admin();
                admin = admin.login_admin(user_id,user_pass);
                if (admin.getId() == "0" || admin.getPass().equals(".")) {
                    out.print("<script>alert('"+admin.getNombre()+"');</script>");
                    out.print("<script>console.log('"+admin.getNombre()+"');</script>");
                    request.getRequestDispatcher("index.jsp").forward(request, response);   
                }else{
                    session.setAttribute("user_current", admin);
                    request.getRequestDispatcher("home_admin.jsp").forward(request, response);
                }                        
                break;
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
