<%-- 
    Document   : resultado_presidente_magistrado
    Created on : 05-abr-2018, 18:14:33
    Author     : alex
--%>

<%@page import="Modelos.Magistrado"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page import="Modelos.Elector"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    List<Candidato_pp> presidentes_planilla_resultado = new ArrayList<Candidato_pp>();
    Magistrado magistrado = new Magistrado();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema Electoral</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>  
    </head>
    <body>
        <%
            if (session.getAttribute("user_current") != null) {
                magistrado = (Magistrado) session.getAttribute("user_current");
            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary row">            
            <img class="card-img-top" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand col-md-9" href="home_magistrado.jsp">Sistema Electoral / Magistrado</a>
            <img class="card-img-top" src="https://image.flaticon.com/icons/svg/167/167750.svg" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <button class="navbar-toggler col-md-2" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">                        
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%= magistrado.getNombre()%>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Mi Perfil</a>
                            <div class="dropdown-divider"></div>
                            <form action="logout" method="post">
                                <button class="dropdown-item" type="submit">Cerrar Sesion</button>
                            </form>
                        </div>
                    </li>                    
                </ul>
            </div>
        </nav>
        <br><br>
        <div class="container-fluid">
            <h1 style="text-align: center;">Resultados para Presidente</h1>
            <br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-8" style="padding:0px;">
                    <table class="table" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Imagen</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Partido Politico</th>
                                <th scope="col">Resultado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                presidentes_planilla_resultado = (ArrayList<Candidato_pp>) session.getAttribute("resultados_gloables_presidente");
                                for (Candidato_pp candidato_current : presidentes_planilla_resultado) {
                            %>
                            <tr>
                                <td><img src="<%=candidato_current.getImagen()%>" class="img-fluid" alt="Imagen <%=candidato_current.getNombre()%>" style="padding:5px; width:90px;"></td>
                                <td><%=candidato_current.getNombre()%></td>
                                <td><%=candidato_current.getPartido_nombre()%></td>
                                <td><%=candidato_current.getConteo_votos()%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
            <br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-3" style="padding:0px;">
                    <a href="generar_reporte_presi.jsp" class="btn btn-info btn-lg">Generar Reporte de Resultados</a>
                </div>
                <div class="card col-12 col-md-3" style="padding:0px;">
                    <a href="graficas_presidente_global.jsp" class="btn btn-success btn-lg">Generar Grafica de Resultados</a>
                </div>
            </div>
            <br><br>
        </div>
                        
    </body>
</html>