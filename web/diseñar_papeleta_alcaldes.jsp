<%-- 
    Document   : diseñar_papeleta_alcaldes
    Created on : 30-mar-2018, 23:49:47
    Author     : alex
--%>

<%@page import="Modelos.Municipio"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelos.Admin"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%!
    List<Candidato_pp> list_alcaldes = new ArrayList<Candidato_pp>();
    List<Candidato_pp> alcaldes_selecciados = new ArrayList<Candidato_pp>();
    List<Municipio> list_muni = new ArrayList<Municipio>();
    Admin admin = new Admin();
    private int CARGO = 1;
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
            alcaldes_selecciados = (ArrayList<Candidato_pp>) session.getAttribute("alcaldes_selecciados");
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
        <br><br>
        <div class="container-fluid">
            <h1 style="text-align: center;">Papeleta de Alcalde</h1>
            <br>
            <form action="cargar_alcaldes_2" method="post">
                <div class="row">
                    <div class="input-group-prepend col-4 col-md-1">
                        <label class="input-group-text" for="select_muni">Municipio:</label>
                    </div>
                    <select class="custom-select col-4 col-md-4" id="select_muni" name="municipio">
                        <option value="0" disabled >Seleccione un Municipio</option>
                        <%
                            session.setAttribute("alcaldes_selecciados",alcaldes_selecciados);
                            list_muni = (ArrayList<Municipio>) request.getAttribute("list_muni");
                            session.setAttribute("list_muni", list_muni);
                            for (Municipio municipio_current : list_muni) {
                        %>
                        <option value="<%=municipio_current.getId()%>"><%=municipio_current.getNombre()%></option>
                        <%}%>
                    </select>
                    <button type="submit" class="btn btn-primary offset-md-1 col-4 col-md-4" >Cambiar</button>
                </div>
            </form>
            <br>
            <div class="row">
                <div class="col-12 col-md-6 justify-content-center">
                    <table class="table table-striped table-bordered" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Imagen</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Partido</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                list_alcaldes = (ArrayList<Candidato_pp>) session.getAttribute("candidatos_alcaldes");
                                for (Candidato_pp candidato_current : list_alcaldes) {
                            %>
                            <tr>
                                <td><img src="<%=candidato_current.getImagen()%>" class="img-fluid" alt="imagen <%=candidato_current.getNombre()%>" style="padding:5px; width:80px;"></td>
                                <td><%=candidato_current.getNombre()%></td>
                                <td><%=candidato_current.getPartido_nombre()%></td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <form action="agregar_candidato_papeleta" method="post">
                                            <div class="col-sm-10" style="display:none;">
                                                <input type="number" class="form-control" name="candidato_id" value="<%=candidato_current.getId()%>">
                                                <input type="number" class="form-control" name="cargo" value="<%=CARGO%>">
                                            </div>
                                            <button type="submit" style="padding:0px; border:none; background:none; margin: 5px;">
                                                <img src="https://image.flaticon.com/icons/svg/189/189755.svg"style="height: 40px; width:40px; -webkit-appearance: none; cursor:pointer;">
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }%>
                        </tbody>
                    </table>
                </div>
                <div class="col-12 col-md-6 justify-content-center">
                    <table class="table table-striped table-bordered" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Posicion</th>
                                <th scope="col">Imagen</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Partido</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                alcaldes_selecciados = (ArrayList<Candidato_pp>) session.getAttribute("alcaldes_selecciados");
                                for (Candidato_pp presidente_current : alcaldes_selecciados) {
                            %>
                            <tr>
                                <td><%=presidente_current.getPosicion()%></td>
                                <td><img src="<%=presidente_current.getImagen()%>" class="img-fluid" alt="imagen <%=presidente_current.getNombre()%>" style="padding:5px; width:80px;"></td>
                                <td><%=presidente_current.getNombre()%></td>
                                <td><%=presidente_current.getPartido_nombre()%></td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <div class="btn-group" role="group" aria-label="Basic example">  
                                            <form action="remover_candidato_papeleta" method="post">
                                                <div class="col-sm-10" style="display:none;">
                                                    <input type="number" class="form-control" name="candidato_id" value="<%=presidente_current.getId()%>">
                                                    <input type="number" class="form-control" name="cargo" value="<%=CARGO%>">
                                                </div>
                                                <button type="submit" style="padding:0px; border:none; background:none; margin: 5px;">
                                                    <img type="submit" src="https://image.flaticon.com/icons/svg/189/189766.svg"style="height: 40px; width:40px; -webkit-appearance: none; cursor:pointer;">
                                                </button>
                                            </form>

                                            <button type="submit" style="padding:0px; border:none; background:none; margin: 5px;">
                                                <img type="submit" src="https://image.flaticon.com/icons/svg/137/137608.svg"style="height: 40px; width:40px; -webkit-appearance: none; cursor:pointer;">
                                            </button>
                                            <button type="submit" style="padding:0px; border:none; background:none; margin: 5px;">
                                                <img type="submit" src="https://image.flaticon.com/icons/svg/137/137609.svg"style="height: 40px; width:40px; -webkit-appearance: none; cursor:pointer;">
                                            </button>
                                        </div>
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
                <div class="card col-12 col-md-6" style="padding:0px;">
                    <a href="cargar_alcaldes" class="btn btn-success btn-lg">Continuar con Diputados</a>

                </div>
            </div>
            <br><br>
        </div>
    </body>
</html>
