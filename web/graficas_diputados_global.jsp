<%-- 
    Document   : graficas_diputados_global
    Created on : 07-abr-2018, 7:20:46
    Author     : alex
--%>

<%@page import="java.math.RoundingMode"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.*"%>
<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.data.general.*"%>
<%
    List<Candidato_pp> presidentes_planilla_resultado = (ArrayList<Candidato_pp>) session.getAttribute("resultados_gloables_diputados");

    //instanciar objeto que corresponde al tipo de grafico
    //se carga la data para las series
    DefaultPieDataset data = new DefaultPieDataset();
    int total_votos=0;
    double porcentaje = 0;
    String departamento= (String) session.getAttribute("dep_name");
    
    for (Candidato_pp candidato_current : presidentes_planilla_resultado) {
        total_votos = total_votos + candidato_current.getConteo_votos();
    }
    for (Candidato_pp candidato_current : presidentes_planilla_resultado) {
        if (candidato_current.getConteo_votos() > 0) {
            porcentaje = Double.parseDouble(candidato_current.getConteo_votos()+"")/Double.parseDouble(total_votos+"");
        }else{
            porcentaje = 0;
        }
        data.setValue(candidato_current.getNombre()+" "+porcentaje+"%", candidato_current.getConteo_votos());
    }

    //generar el grafico
    JFreeChart grafico = ChartFactory.createPieChart("Resultados Diputados Departamento "+departamento+" 2018", data,true,true,true);

    //creamos el medio donde se mostrara el grafico
    response.setContentType("image/JPEG");
    OutputStream sa = response.getOutputStream();

    //imprimir el grafico
    ChartUtilities.writeChartAsJPEG(sa, grafico, 500, 500);
%>