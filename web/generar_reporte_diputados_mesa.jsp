<%-- 
    Document   : generar_reporte_diputados_mesa
    Created on : 05-abr-2018, 0:15:37
    Author     : alex
--%>

<%@page import="Modelos.Departamento"%>
<%@page import="Modelos.Municipio"%>
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
    Mesa_Electoral mesa_electoral = (Mesa_Electoral)session.getAttribute("mesa_electora_current");
    Admin admin = (Admin) session.getAttribute("user_current");
    
    Municipio municipio = new Municipio();
    List<Municipio> list_muni = Municipio.getAllMunicipios();
    for (Municipio municipio_current : list_muni) {
            if (municipio_current.getId() == mesa_electoral.getId_municipio()) {
                municipio = municipio_current;
            }
    }
    
    Resultado resultados_diputados = Resultado.buscar_resultado(mesa_electoral.getId(),3,municipio.getId_dep(),0);
    List<Conteo> conteos = Conteo.getCuentas(resultados_diputados.getId());
    
    List<Candidato_pp> list_dipus = Candidato_pp.getCandidatos_por_posicion(3,0,municipio.getId_dep());
    List<Papeleta> dipus_papeleta = Papeleta.getAllDiputado(3,municipio.getId_dep());

    List<Candidato_pp> diputados_planilla = new ArrayList<Candidato_pp>();
    List<Partido_politico> list_partidos = Partido_politico.getAllPartidosp();
    
    for (Papeleta alcalde_papeleta : dipus_papeleta) {
        for (Candidato_pp candidato_current : list_dipus) {
            if (candidato_current.getId() == alcalde_papeleta.getId_candidato()) {
                candidato_current.setPosicion(alcalde_papeleta.getPosicion());
                diputados_planilla.add(candidato_current);
            }   
        }
    }

    for (Candidato_pp candidato_current : diputados_planilla) {
        for (Partido_politico partido_current : list_partidos) {
            if (candidato_current.getPartido_id() == partido_current.getId()) {
                candidato_current.setPartido_nombre(partido_current.getNombre());
                candidato_current.setImagen_partido(partido_current.getLogo());
            }
        }
    }
    
    for (Candidato_pp candidato_current : diputados_planilla) {
        for (Conteo conteo_current : conteos) {
            if (conteo_current.getId_candidato() == candidato_current.getId()) {
                candidato_current.setConteo_votos(conteo_current.getCuenta());
            }
        }
    }            

    //configurar el header y el tipo
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", 
            "attachment; filename=\"Reporte de resutados diputados de Mesa Electoral "+mesa_electoral.getId()+".pdf\"");
    
    try {
        //crear y abrir documento tipo pdf
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        //algunos parametros
        document.addAuthor("Kevin Pinzon");
        document.addCreator(""+admin.getNombre());
        document.addSubject("Reporte de resutados diputados de Mesa Electoral "+mesa_electoral.getId());
        document.addCreationDate();
        document.addTitle("DAW-PDF");
        
        //insertar html
        int contador = 0;
        HTMLWorker htmlWorker = new HTMLWorker(document);
        String str = "<html><head></head><body>"+
        "<br>" +
        "<h1>Resutados Mesa Electoral</h1>" +
        "<br>" +
        "<p class='lead'><strong>Codigo de Mesa Electoral: </strong>"+mesa_electoral.getId()+"</p>" +
        "<p class='lead'><strong>Departamento: </strong>"+ mesa_electoral.getDepartamento_cadena()+"</p>" +
        "<p class='lead'><strong>Municipio: </strong>"+ mesa_electoral.getMunicipio_cadena()+"</p>" +
        "<p class='lead'><strong>Ubicacion: </strong>"+ mesa_electoral.getLugar_nombre()+"</p>" +
        "<p class='lead'><strong>Descripcion del lugar: </strong>"+ mesa_electoral.getLugar_descripcion()+"</p>"+
        "<br><br>" +
        "<h3 style='text-align: center;'>Resultados para Diputados</h3>"+
        "<br>"+                
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
        for (Candidato_pp presi_current : diputados_planilla) {
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