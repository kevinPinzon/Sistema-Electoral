<%-- 
    Document   : generar_resultados_por_mesa_magistrado
    Created on : 06-abr-2018, 11:22:57
    Author     : alex
--%>

<%@page import="Modelos.Municipio"%>
<%@page import="Modelos.Partido_politico"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page import="Modelos.Papeleta"%>
<%@page import="Modelos.Conteo"%>
<%@page import="Modelos.Resultado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Miembro"%>
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
    List<Mesa_Electoral> list_me = (ArrayList<Mesa_Electoral>)session.getAttribute("list_me");
    int id = Integer.parseInt(request.getParameter("me_id"));

    Mesa_Electoral mesa_electoral = new Mesa_Electoral();
    for (Mesa_Electoral me_current : list_me) {
        if (me_current.getId() == id){
            mesa_electoral = me_current;
        }
    }
    
    //cargando presidentes
    Resultado resultados_presidente = Resultado.buscar_resultado(mesa_electoral.getId(),1,0,0);
    List<Conteo> conteos_presi = Conteo.getCuentas(resultados_presidente.getId());
    
    List<Candidato_pp> list_presidentes = Candidato_pp.getCandidatos_por_posicion(1,0,0);
    List<Papeleta> presidentes_papeleta = Papeleta.getAllPresidentes(1);
    
    List<Candidato_pp> presidenes_planilla = new ArrayList<Candidato_pp>();
    
    for (Papeleta presidente_papeleta : presidentes_papeleta) {
        for (Candidato_pp candidato_current : list_presidentes) {
            if (candidato_current.getId() == presidente_papeleta.getId_candidato()) {
                candidato_current.setPosicion(presidente_papeleta.getPosicion());
                presidenes_planilla.add(candidato_current);
            }   
        }
    }
    
    List<Partido_politico> list_partidos = Partido_politico.getAllPartidosp();
    for (Candidato_pp candidato_current : presidenes_planilla) {
        for (Partido_politico partido_current : list_partidos) {
            if (candidato_current.getPartido_id() == partido_current.getId()) {
                candidato_current.setPartido_nombre(partido_current.getNombre());
                candidato_current.setImagen_partido(partido_current.getLogo());
            }
        }
    }
    
    for (Candidato_pp candidato_current : presidenes_planilla) {
        for (Conteo conteo_current : conteos_presi) {
            if (conteo_current.getId_candidato() == candidato_current.getId()) {
                candidato_current.setConteo_votos(conteo_current.getCuenta());
            }
        }
    }
    
    //cargando alcaldes
    Resultado resultados_alcalde = Resultado.buscar_resultado(mesa_electoral.getId(),2,0,mesa_electoral.getId_municipio());
    List<Conteo> conteos_alcalde = Conteo.getCuentas(resultados_alcalde.getId());
    
    List<Candidato_pp> list_alcaldes = Candidato_pp.getCandidatos_por_posicion(2,mesa_electoral.getId_municipio(),0);
    List<Papeleta> alcaldes_papeleta = Papeleta.getAllAlcaldes(2,mesa_electoral.getId_municipio());
    
    List<Candidato_pp> alcaldes_planilla = new ArrayList<Candidato_pp>();

    for (Papeleta presidente_papeleta : alcaldes_papeleta) {
        for (Candidato_pp candidato_current : list_alcaldes) {
            if (candidato_current.getId() == presidente_papeleta.getId_candidato()) {
                candidato_current.setPosicion(presidente_papeleta.getPosicion());
                alcaldes_planilla.add(candidato_current);
            }   
        }
    }

    for (Candidato_pp candidato_current : alcaldes_planilla) {
        for (Partido_politico partido_current : list_partidos) {
            if (candidato_current.getPartido_id() == partido_current.getId()) {
                candidato_current.setPartido_nombre(partido_current.getNombre());
                candidato_current.setImagen_partido(partido_current.getLogo());
            }
        }
    }
    
    for (Candidato_pp candidato_current : alcaldes_planilla) {
        for (Conteo conteo_current : conteos_alcalde) {
            if (conteo_current.getId_candidato() == candidato_current.getId()) {
                candidato_current.setConteo_votos(conteo_current.getCuenta());
            }
        }
    }
    
    //cargando diputados
    Municipio municipio = new Municipio();
    List<Municipio> list_muni = Municipio.getAllMunicipios();
    for (Municipio municipio_current : list_muni) {
            if (municipio_current.getId() == mesa_electoral.getId_municipio()) {
                municipio = municipio_current;
            }
    }
    
    Resultado resultados_diputados = Resultado.buscar_resultado(mesa_electoral.getId(),3,municipio.getId_dep(),0);
    List<Conteo> conteos_diputados = Conteo.getCuentas(resultados_diputados.getId());
    
    List<Candidato_pp> list_dipus = Candidato_pp.getCandidatos_por_posicion(3,0,municipio.getId_dep());
    List<Papeleta> dipus_papeleta = Papeleta.getAllDiputado(3,municipio.getId_dep());

    List<Candidato_pp> diputados_planilla = new ArrayList<Candidato_pp>();
    
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
        for (Conteo conteo_current : conteos_diputados) {
            if (conteo_current.getId_candidato() == candidato_current.getId()) {
                candidato_current.setConteo_votos(conteo_current.getCuenta());
            }
        }
    }
    
    //configurar el header y el tipo
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", 
            "attachment; filename=\"Reporte de Resultados de la Mesa Electoral "+mesa_electoral.getId()+".pdf\"");
    
    try {
        //crear y abrir documento tipo pdf
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        //algunos parametros
        document.addAuthor("Kevin Alexander Pinzon");
        document.addCreator("Kevin Alexander Pinzon");
        document.addSubject("Reporte de Resultados de la Mesa Electoral "+mesa_electoral.getId());
        document.addCreationDate();
        document.addTitle("Reporte de Resultados de la Mesa Electoral "+mesa_electoral.getId());
        
        //insertar html
        int contador = 0;
        int total_votos = 0;
        HTMLWorker htmlWorker = new HTMLWorker(document);
        String str_miembro = "<html><head></head><body>"+
        "<br>" +
        
        // uniendo informacion general de mesa
        
        "<h1>Reporte de Resultados de la Mesa Electoral "+mesa_electoral.getId()+"</h1>" +
        "<br>" +
        "<p class='lead'><strong>Codigo de Mesa Electoral: </strong>"+mesa_electoral.getId()+"</p>" +
        "<p class='lead'><strong>Departamento: </strong>"+ mesa_electoral.getDepartamento_cadena()+"</p>" +
        "<p class='lead'><strong>Municipio: </strong>"+ mesa_electoral.getMunicipio_cadena()+"</p>" +
        "<p class='lead'><strong>Ubicacion: </strong>"+ mesa_electoral.getLugar_nombre()+"</p>" +
        "<p class='lead'><strong>Descripcion del lugar: </strong>"+ mesa_electoral.getLugar_descripcion()+"</p>"+
        "<p class='lead'><strong>Se Aperturo: </strong>"+ mesa_electoral.getApertura()+"</p>" +
        "<p class='lead'><strong>Se Cerro: </strong>"+ mesa_electoral.getCierre()+"</p>" +
        "<br><br>";
        
        // uniendo presidentes
        
        String str_presi ="<h3 style='text-align: center;'>Resultados para Presidente</h3>"+
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
        ArrayList<String> rows_presi = new ArrayList<String>();
        contador=0;
        total_votos=0;
        for (Candidato_pp presi_current : presidenes_planilla) {
            total_votos = total_votos + presi_current.getConteo_votos();
            contador++;
            String str_temp = "<tr>"+
                "<td>"+contador+"</td>"+
                "<td>"+presi_current.getNombre()+"</td>"+
                "<td>"+presi_current.getPartido_nombre()+"</td>"+
                "<td>"+presi_current.getConteo_votos()+"</td>"+
                "</tr>";
            rows_presi.add(str_temp);
        }
        String str_final_presi = "</tbody>"+
                     "</table>"+
                 "</div>"+
             "</div>"+
            "<h4 style='text-align: center;'>Total de Votos: "+total_votos+"</h4>"+
             "<br><br>";
        
        String content_report_presi = str_miembro + str_presi;
        for (String row_current : rows_presi) {
            content_report_presi = content_report_presi+row_current;
        }
        content_report_presi = content_report_presi+str_final_presi;
        
        //uniendo alcaldes
        
        String str_alcalde ="<h3 style='text-align: center;'>Resultados para Alcalde</h3>"+
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
        ArrayList<String> rows_alcalde = new ArrayList<String>();
        contador=0;
        total_votos=0;
        for (Candidato_pp presi_current : alcaldes_planilla) {
            total_votos = total_votos + presi_current.getConteo_votos();
            contador++;
            String str_temp = "<tr>"+
                "<td>"+contador+"</td>"+
                "<td>"+presi_current.getNombre()+"</td>"+
                "<td>"+presi_current.getPartido_nombre()+"</td>"+
                "<td>"+presi_current.getConteo_votos()+"</td>"+
                "</tr>";
            rows_alcalde.add(str_temp);
        }
        String str_final_alcalde = "</tbody>"+
                     "</table>"+
                 "</div>"+
             "</div>"+
            "<h4 style='text-align: center;'>Total de Votos: "+total_votos+"</h4>"+
             "<br><br>";
        
        String content_report_alcalde = str_alcalde;
        for (String row_current : rows_alcalde) {
            content_report_alcalde = content_report_alcalde+row_current;
        }
        content_report_alcalde = content_report_alcalde+str_final_alcalde;
        
        //uniendo diputados
        
        String str_diputados =
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
        ArrayList<String> rows_diputados = new ArrayList<String>();
        contador= 0;
        total_votos=0;
        for (Candidato_pp presi_current : diputados_planilla) {
            total_votos = total_votos + presi_current.getConteo_votos();
            contador++;
            String str_temp = "<tr>"+
                "<td>"+contador+"</td>"+
                "<td>"+presi_current.getNombre()+"</td>"+
                "<td>"+presi_current.getPartido_nombre()+"</td>"+
                "<td>"+presi_current.getConteo_votos()+"</td>"+
                "</tr>";
            rows_diputados.add(str_temp);
        }
        String str_final_diputado = "</tbody>"+
                     "</table>"+
                 "</div>"+
             "</div>"+
             "<h4 style='text-align: center;'>Total de Votos: "+total_votos+"</h4>"+
             "<br><br>"+
        "</body></html>";
        
        String content_report_diputados = str_diputados;
        for (String row_current : rows_diputados) {
            content_report_diputados = content_report_diputados+row_current;
        }
        content_report_diputados = content_report_diputados+str_final_diputado;
        
        String content_report = content_report_presi + content_report_alcalde + content_report_diputados;
        htmlWorker.parse(new StringReader(content_report)); 

        // cerrar el documento
        document.close();
    } catch (DocumentException de) {
        throw new IOException(de.getMessage());
    }
%>
