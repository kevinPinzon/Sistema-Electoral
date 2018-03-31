<%-- 
    Document   : mesa_electoral_detalles_mm
    Created on : 06-mar-2018, 13:13:24
    Author     : alexanderpinzon
--%>

<%@page import="Modelos.Mesa_Electoral"%>
<%@page import="Modelos.Elector"%>
<%@page import="Modelos.Miembro"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Miembro miembro = new Miembro();
    Mesa_Electoral mesa_electoral = new Mesa_Electoral();
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
                miembro = (Miembro) session.getAttribute("user_current");
                mesa_electoral = (Mesa_Electoral) session.getAttribute("mesa_electora_current");
            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary row">
            <img class="card-img-top" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand col-md-9" href="home_miembro_mesa.jsp">Sistema Electoral / Miembro de Mesa (<%= miembro.getId_mesa()%>)</a>
            <img class="card-img-top" src="https://image.flaticon.com/icons/svg/145/145859.svg" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <button class="navbar-toggler col-md-2" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%= miembro.getNombre()%>
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
        <div class="jumbotron">
            <h1 class="display-4">Mesa Electoral</h1>
            <p class="lead"><strong><%= miembro.getNombre()%></strong> eres parte de la mesa electoral con codigo <strong><%= miembro.getId_mesa()%></strong>.
            <p class="lead">
                Una mesa electoral es un órganos formado por ciudadanos elegidos por sorteo, encargados de recibir los votos de los ciudadanos, de hacer el recuento en un proceso de elecciones,
                habilitar los electores, aperturar y dar cierre a las votaciones de su mesa electoral.</p>
            <hr class="my-4">
            <img src="https://applesutra.com/wp-content/uploads/2015/09/google-maps-realtime-location.png" class="img-fluid" alt="Ubicacion de mesa electoral ####" style="padding:5px; height:200px;">
              <p class="lead"><strong>Ubicacion: </strong><%= mesa_electoral.getLugar_nombre()%></p>
              <p class="lead"><strong>Descripcion del lugar: </strong><%= mesa_electoral.getLugar_descripcion()%></p>
            <p class="lead">
                <%if (mesa_electoral.getEstado() == 2) {%>
                <form action="cambiar_estado_mesa" method="post">
                    <div class="col-sm-10" style="display:none;">
                        <input type="number" class="form-control" name="me_id" value="<%=mesa_electoral.getId()%>">
                        <input type="number" class="form-control" name="estado" value="<%=3%>">
                    </div>
                    <button class="btn btn-danger btn-lg" type="submit">Cerrar Mesa</button>
                </form>
                <%}else if (mesa_electoral.getEstado() == 1) {%>
                <form action="cambiar_estado_mesa" method="post">
                    <div class="col-sm-10" style="display:none;">
                        <input type="number" class="form-control" name="me_id" value="<%=mesa_electoral.getId()%>">
                        <input type="number" class="form-control" name="estado" value="<%=2%>">
                    </div>
                    <button class="btn btn-success btn-lg" type="submit">Aperturar Mesa</button>
                </form>
                <%}%>
            </p>
        </div>
    </body>
</html>
