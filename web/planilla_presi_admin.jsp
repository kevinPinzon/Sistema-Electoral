<%-- 
    Document   : planilla_presi_admin
    Created on : 01-abr-2018, 23:27:19
    Author     : alex
--%>

<%@page import="Modelos.Candidato_pp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelos.Admin"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%!
    List<Candidato_pp> presidentes_planilla = new ArrayList<Candidato_pp>();
    Admin admin = new Admin();
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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body>
        <%
            if (session.getAttribute("user_current") != null) {
                admin = (Admin) session.getAttribute("user_current");
            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary row">
            <img class="card-img-top" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand col-md-9" href="home_admin.jsp">Sistema Electoral / Administrador de Sistema</a>
            <img class="card-img-top" src="https://image.flaticon.com/icons/svg/608/608941.svg" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <button class="navbar-toggler col-md-2" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">                        
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%= admin.getNombre()%>
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
        <br>
        <div class="container">
            <h1 style="text-align: center;">Planilla Presidencial</h1>
            <br>
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
                            </div>
                        </div>
                    </div>
            <%
              }
            %>
            </div>
        </div>        
    </body>
</html>
