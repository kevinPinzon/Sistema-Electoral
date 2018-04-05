<%-- 
    Document   : generar_reporte_presi
    Created on : 05-abr-2018, 8:24:44
    Author     : alex
--%>

<%@page import="Modelos.Partido_politico"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page import="Modelos.Papeleta"%>
<%@page import="Modelos.Conteo"%>
<%@page import="Modelos.Resultado"%>
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
    List<Candidato_pp> resultados_gloables_presidente = (List<Candidato_pp>) session.getAttribute("resultados_gloables_presidente");
    
    //configurar el header y el tipo
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", 
            "attachment; filename=\"Reporte de resutados presidenciales.pdf\"");
    
    try {
        //crear y abrir documento tipo pdf
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        //algunos parametros
        document.addAuthor("Kevin Pinzon");
        document.addCreator("Kevin Pinzon");
        document.addSubject("Reporte de resutados presidenciales");
        document.addCreationDate();
        document.addTitle("DAW-PDF");
        
        //insertar html
        int contador = 0;
        HTMLWorker htmlWorker = new HTMLWorker(document);
        String str = "<html><head></head><body>"+
        "<br>" +
        "<h2 style='text-align: center;'>Resultados para Presidente 2018</h2>"+
        "<br><br>"+                
        "<div class='row justify-content-center'>"+
                 "<div class='card col-12 col-md-8' style='padding:0px;'>"+
                     "<table border='1'>"+
                         "<thead>"+
                             "<tr style='text-align: center;' bgcolor='black' color='white'>"+
                                 "<th scope='col'>No.</th>"+
                                 "<th scope='col'>Nombre</th>"+
                                 "<th scope='col'>Partido Politico</th>"+
                                 "<th scope='col'>Resultado</th>"+
                             "</tr>"+
                         "</thead>"+
                         "<tbody>";
        ArrayList<String> rows = new ArrayList<String>();
        for (Candidato_pp presi_current : resultados_gloables_presidente) {
            contador++;
            String str_temp = "<tr>"+
                "<td>"+contador+"</td>"+
                "<td>"+presi_current.getNombre()+"</td>"+
                "<td>"+presi_current.getPartido_nombre()+"</td>"+
                "<td>"+presi_current.getConteo_votos()+"</td>"+
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

%>
