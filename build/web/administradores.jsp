<%-- 
    Document   : administradores
    Created on : 27-mar-2018, 22:57:10
    Author     : alex
--%>
<%@page import="Modelos.Admin"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Admin admin = new Admin();
    List<Admin> list_admins = new ArrayList<Admin>();
    private int contador = 0;
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
                admin = (Admin) session.getAttribute("user_current");
            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary row">
            <img class="card-img-top" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand col-md-10" href="home_admin.jsp">Sistema Electoral / Administrador de Sistema</a>
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
        <br><br>
        <div class="container-fluid">
            <h1 style="text-align: center;">Administradores del Sistema</h1>
            <br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-8" style="padding:0px;">
                    <table class="table" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                contador = 1;
                                list_admins = (ArrayList<Admin>) request.getAttribute("list_admins");
                                for (Admin admin_current : list_admins) {
                            %>
                            <tr>
                                <th scope="row"><%=contador++%></th>
                                <td><%=admin_current.getId()%></td>
                                <td><%=admin_current.getNombre()%></td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>                                        
                                        <button type="button" class="btn btn-danger">Eliminar</button>    
                                    </div>
                                </td>
                            </tr>
                            <%
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>
            <br><br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-4" style="padding:0px;">
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#newadmin">Crear Nuevo Administrador</button>
                </div>
            </div>
        </div>
        <div class="modal fade" id="newadmin" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo Administrador del Sistema</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="agregar_admin" method="post">
                            <div class="form-group row">
                                <label for="admin_nombre" class="col-sm-3 col-form-label">Nombre: </label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="admin_nombre" name="admin_nombre">
                                    <br>
                                </div>
                                <label for="admin_pass" class="col-sm-3 col-form-label">Contraseña: </label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="admin_pass" name="admin_pass">
                                </div>
                                <div class="col-sm-10" style="display:none;">
                                    <input type="number" class="form-control" name="admin_id"
                                           value="<%=contador++%>">
                                </div>
                            </div>                                     
                            <button type="submit" class="btn btn-success">Guardar</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
