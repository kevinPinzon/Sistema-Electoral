<%-- 
    Document   : votacion_presidentes
    Created on : 02-abr-2018, 20:41:15
    Author     : alex
--%>

<%@page import="Modelos.Candidato_pp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Modelos.Elector"%>
<%@page import="Modelos.Mesa_Electoral"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Elector elector = new Elector();
    Mesa_Electoral mesa_electoral = new Mesa_Electoral();
    List<Candidato_pp> presidentes_planilla = new ArrayList<Candidato_pp>();
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
                elector = (Elector) session.getAttribute("user_current");
            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            mesa_electoral = (Mesa_Electoral) session.getAttribute("mesa_electoral_current");
        %>

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary row">
            <img class="card-img-top" href="home_elector.jsp" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand col-md-9" href="home_elector.jsp">Sistema Electoral / Elector (<%= elector.getId()%>)</a>
            <img class="card-img-top" src="https://image.flaticon.com/icons/svg/145/145859.svg" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <button class="navbar-toggler col-md-2" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%= elector.getNombre()%>
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
        <%
            if (elector.getEstado() == 2) {
                if (mesa_electoral.getEstado() == 2) {
        %>
            
        <div class="container">
            <h1 style="text-align: center;">Planilla Presidencial</h1>
            <br>
            <form action="votar_presidente" method="post">
                <div class="row" style="margin-bottom: 10px;">                
                    <%
                        presidentes_planilla = (ArrayList<Candidato_pp>) session.getAttribute("presidentes_planilla");
                        for (Candidato_pp presidente_current : presidentes_planilla) {%>
                            <div class="col-12 col-md-2" style="padding: 0.5px;text-align: -webkit-center;">
                                <div class="card" style="width: 8.5rem;border: solid 1px gold;">
                                    <img class="card-img-top" src="<%=presidente_current.getImagen_partido()%>" alt="imagen partido" style="padding:0px;margin:0px;height: 90px;">
                                    <div class="card-body" style="padding: 5px;height: 220px !important;background: whitesmoke;">
                                        <img class="card-img-top" src="<%=presidente_current.getImagen()%>" alt="imagen partido" style="padding:0px;margin:0px;height: 100px;">
                                        <h6 class="card-title" style="margin:0px;"><%=presidente_current.getNombre()%></h6>
                                        <h7><%=presidente_current.getPartido_nombre()%></h7>
                                        <br>
                                        <input type="radio" name="presidente" value="<%=presidente_current.getId()%>" checked="checked" />
                                    </div>
                                </div>
                            </div>                            
                    <%
                      }
                    %>
                </div>
                <br><br>
                <div class="row justify-content-center">
                    <div class="col-sm-10" style="display:none;">
                        <input type="number" class="form-control" name="me_id" value="<%=mesa_electoral.getId()%>">
                    </div>
                    <div class="card col-12 col-md-6" style="padding:0px;">
                        <button type="submit" class="btn btn-success btn-lg">Votar</button>
                    </div>
                    <br><br>
            </div>
            </form>
        </div> 
            
            <%  }else{%>
            <h1 class="display-4">Mesa Electoral NO habilitada</h1>  
            <br><br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-4" style="padding:0px;">
                    <a href="cargar_informacion_elector" class="btn btn-primary">Mas Informacion</a>
                </div>
            </div>
            <%  }
            }else{%>
            <h1 class="display-4">No estas habilitado para votar</h1>
            <br><br>            
            <div class="row justify-content-center">
                <div class="card col-12 col-md-4" style="padding:0px;">
                    <a href="cargar_informacion_elector" class="btn btn-primary">Mas Informacion</a>
                </div>
            </div>            
            <%}%>        
    </body>
</html>
