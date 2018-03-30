<%-- 
    Document   : procesar_diputado
    Created on : 30-mar-2018, 6:59:30
    Author     : alex
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String dir = "";
        ServletFileUpload fu = new ServletFileUpload(new DiskFileItemFactory()); //apache 7 
        List items = fu.parseRequest(new ServletRequestContext(request)); //apache 814 en adelante

        Iterator i = items.iterator();
        String fileName = "";
        String link = "";
        File fichero = null;
        int cont = 0;
        while (i.hasNext()) {
            FileItem ft = (FileItem) i.next();
            if (!ft.isFormField()) {//cuando es un archivo
                long a = ft.getSize();
                if (a > 0) {
                    fileName = ft.getName();
                    fichero = new File(fileName);
                    fichero = new File(application.getRealPath(""), fichero.getName());
                    ft.write(fichero);
                    
                    //en caso que sea una imagen, hay que mostrarla
                    if (ft.getContentType().equals("image/jpeg")
                            || ft.getContentType().equals("image/png")
                            || ft.getContentType().equals("image/gif")
                            || ft.getContentType().equals("image/pjpeg")) {
                        session.setAttribute("imagen", fichero.getName());
                    }
                }

            }else{
                cont++;
                if (cont == 1) {
                    session.setAttribute("candidato_nombre", ft.getString());
                }else if (cont == 2) {
                    session.setAttribute("departamento", ft.getString());
                }else if (cont == 3) {
                    session.setAttribute("id_pp", ft.getString());
                }else{
                    session.setAttribute("id", ft.getString());
                }
            }
        }
        request.getRequestDispatcher("agregar_diputado").forward(request, response);
%>