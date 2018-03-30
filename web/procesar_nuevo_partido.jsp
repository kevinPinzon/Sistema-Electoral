<%-- 
    Document   : procesar_nuevo_partido
    Created on : 29-mar-2018, 23:44:58
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
                        session.setAttribute("logo", fichero.getName());
                    }
                }

            }else{
                cont++;
                if (cont == 1) {
                    session.setAttribute("partidopolitico_nombre", ft.getString());
                }else{
                    session.setAttribute("partidopolitico_id", ft.getString());
                }
            }
        }
        request.getRequestDispatcher("agregar_partido_politico").forward(request, response);
%>