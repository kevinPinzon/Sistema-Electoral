<%-- 
    Document   : generar_reporte_mesa
    Created on : 04-abr-2018, 19:51:47
    Author     : alex
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Miembro"%>
<%@page import="Modelos.Admin"%>
<%@page import="Modelos.Mesa_Electoral"%>
<%@page import="java.io.StringReader"%>
<%@page import="com.lowagie.text.html.simpleparser.HTMLWorker"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>

<%
    
    Mesa_Electoral mesa_electoral = (Mesa_Electoral)session.getAttribute("mesa_electora_current");
    Admin admin = (Admin) session.getAttribute("user_current");
    List<Miembro> list_miembros = Miembro.getAllMiembros(mesa_electoral.getId());
    
    //configurar el header y el tipo
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", 
            "attachment; filename=\"Reporte Mesa Electoral "+mesa_electoral.getId()+".pdf\"");
    try {
        //crear y abrir documento tipo pdf
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        //algunos parametros
        document.addAuthor("Kevin Pinzon");
        document.addCreator(""+admin.getNombre());
        document.addSubject("Reporte Mesa Electoral "+mesa_electoral.getId());
        document.addCreationDate();
        document.addTitle("DAW-PDF");
        
        //insertar html
        int contador = 0;
        HTMLWorker htmlWorker = new HTMLWorker(document);
        String str = "<html><head></head><body>"+
        "<br>" +
        "<h1>Reporta de Mesa Electoral con codigo: "+mesa_electoral.getId()+"</h1>" +
        "<br>" +
        "<p class='lead'><strong>Codigo de Mesa Electoral: </strong>"+mesa_electoral.getId()+"</p>" +
        "<p class='lead'><strong>Departamento: </strong>"+ mesa_electoral.getDepartamento_cadena()+"</p>" +
        "<p class='lead'><strong>Municipio: </strong>"+ mesa_electoral.getMunicipio_cadena()+"</p>" +
        "<p class='lead'><strong>Ubicacion: </strong>"+ mesa_electoral.getLugar_nombre()+"</p>" +
        "<p class='lead'><strong>Descripcion del lugar: </strong>"+ mesa_electoral.getLugar_descripcion()+"</p>"+
        "<br><br>" +
        "<h3 style='text-align: center;'>Miembros de Mesa Electoral </h3>"+
        "<br>"+                
        "<div class='row justify-content-center'>"+
                 "<div class='card col-12 col-md-8' style='padding:0px;'>"+
                     "<table border='1'>"+
                         "<thead>"+
                             "<tr style='text-align: center;' bgcolor='black' color='white'>"+
                                 "<th scope='col'>No.</th>"+
                                 "<th scope='col'>Nombre</th>"+
                                 "<th scope='col'>Num. Credencial</th>"+
                                 "<th scope='col'>Cargo</th>"+
                             "</tr>"+
                         "</thead>"+
                         "<tbody>";
        ArrayList<String> rows = new ArrayList<String>();
        for (Miembro miembro_current : list_miembros) {
            contador++;
            String str_temp = "<tr>"+
                "<td>"+contador+"</td>"+
                "<td>"+miembro_current.getNombre()+"</td>"+
                "<td>"+miembro_current.getId()+"</td>"+
                "<td>"+miembro_current.getCargo_cadena()+"</td>"+
                "</tr>";
            rows.add(str_temp);
        }
        String str_final = "</tbody>"+
                     "</table>"+
                 "</div>"+
             "</div>"+
             "<br><br>"+
        "</body></html>";
        
        String content_report = str;
        for (String row_current : rows) {
            content_report = content_report+row_current;
        }
        content_report = content_report+str_final;
        htmlWorker.parse(new StringReader(content_report)); 

        // cerrar el documento
        document.close();
    } catch (DocumentException de) {
        throw new IOException(de.getMessage());
    }
    request.getRequestDispatcher("cargar_mesas_electorales.jsp").forward(request, response);
%>

