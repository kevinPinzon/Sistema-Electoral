<%-- 
    Document   : home_miembro_mesa
    Created on : 06-mar-2018, 12:36:41
    Author     : alexanderpinzon
--%>

<%@page import="Modelos.Miembro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    Miembro miembro = new Miembro();
%>
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
            miembro = (Miembro)session.getAttribute("user_current");
        }else{
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        %>
        
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary row">
            <img class="card-img-top" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand col-md-10" href="#">Sistema Electoral / Miembro de Mesa (<%= miembro.getId_mesa()%>)</a>
            <img class="card-img-top" src="https://image.flaticon.com/icons/svg/145/145859.svg" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <button class="navbar-toggler col-md-2" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%= miembro.getNombre() %>
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
        <div class="container">
            <div class="row">
                <div class="col-sm">
                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="https://image.flaticon.com/icons/svg/265/265667.svg" alt="Card image cap" style="padding:5px; height:170px;">
                        <div class="card-body">
                            <h6 class="card-title">Electores</h6>                    
                            <a href="cargar_electores_miembro" class="btn btn-primary">Ver mas</a>
                        </div>
                    </div>        
                </div>
                <div class="col-sm">
                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="https://image.flaticon.com/icons/svg/235/235252.svg" alt="Card image cap" style="padding:5px; height:170px;">
                        <div class="card-body">
                            <h6 class="card-title">Informacion de Mesa Electoral</h6>                    
                            <a href="mesa_electoral_detalles_mm.jsp" class="btn btn-primary">Ver mas</a>
                        </div>
                    </div>        
                </div>
                <div class="col-sm">
                    <div class="card" style="width: 18rem;">    
                        <img class="card-img-top" src="https://image.flaticon.com/icons/svg/734/734917.svg" alt="Card image cap" style="padding:5px; height:170px;">
                        <div class="card-body">
                            <h6 class="card-title">Votantes</h6>                    
                            <a href="votantes.jsp" class="btn btn-primary">Ver mas</a>
                        </div>
                    </div>        
                </div>
            </div>
            
            <br>
            
            <div class="row">                
                <div class="col-6 col-md-4">
                    <div class="card" style="width: 18rem;">
                        
                        <img class="card-img-top" src="https://image.flaticon.com/icons/svg/138/138351.svg" alt="Card image cap" style="padding:5px; height:170px;">
                        <div class="card-body">
                            <h6 class="card-title">Resultados</h6>                    
                            <a href="#" class="btn btn-primary">Ver mas</a>
                        </div>
                    </div>        
                </div>
            </div>
            <br>
        </div>
    </body>
</html>
