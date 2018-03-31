<%-- 
    Document   : candidato_partido_politico
    Created on : 06-mar-2018, 12:15:43
    Author     : alexanderpinzon
--%>

<%@page import="Modelos.Admin"%>
<%@page import="Modelos.Departamento"%>
<%@page import="Modelos.Municipio"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    List<Candidato_pp> list_candidatos = new ArrayList<Candidato_pp>();
    List<Departamento> list_dep = new ArrayList<Departamento>();
    List<Municipio> list_muni = new ArrayList<Municipio>();
    private int contador = 0,contador_dipu = 0;
    private boolean have_presi = false;
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
        <br><br>
        <div class="container-fluid">

            <h1 style="text-align: center;"><%=request.getAttribute("partidopolitico_name")%></h1>
            <br>

            <div class="row justify-content-center">
                <br>
                <div class="card col-6 col-md-6" style="padding:0px;">
                    <br>
                    <h4 style="text-align: center;">Candidato a Presidente</h4>
                    <br>
                    <table class="table" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Imagen</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                have_presi = false;
                                list_candidatos = (ArrayList<Candidato_pp>) request.getAttribute("candidatos_pp");
                                request.setAttribute("candidatos_pp", list_candidatos);
                                for (Candidato_pp candidato_current : list_candidatos) {
                                    if (candidato_current.getCargo() == 1) {
                                        have_presi = true;
                            %>
                            <tr>
                                <td><img src="<%=candidato_current.getImagen()%>" class="img-fluid" alt="Imagen <%=candidato_current.getNombre()%>" style="padding:5px; width:90px;"></td>
                                <td><%=candidato_current.getNombre()%></td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>
                                        <form action="delete_candidato" method="post">
                                             <div class="col-sm-10" style="display:none;">
                                                 <input type="text" class="form-control" name="candidato_id"
                                                        value="<%=candidato_current.getId()%>">
                                             </div>
                                             <button type="submit" class="btn btn-danger">Eliminar</button>    
                                         </form>
                                    </div>
                                </td>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>
            <br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-4" style="padding:0px;">
                    <button type="button" class="btn btn-primary btn-lg " data-toggle="modal" data-target="#presi_modal"
                            <%if (have_presi) {
                            %>disabled
                            <%} else {
                            %>active
                            <%}%>
                            >Agregar Presidente</button>
                </div>
            </div>
            <br><br>
            <div class="row justify-content-center">
                <div class="card col-6 col-md-6" style="padding:0px;">
                    <br>
                    <h4 style="text-align: center;">Candidatos a Alcande</h4>
                    <br>
                    <table class="table" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Imagen</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Departamento</th>
                                <th scope="col">Municipio</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                list_candidatos = (ArrayList<Candidato_pp>) request.getAttribute("candidatos_pp");
                                int contador_temp = 1;
                                for (Candidato_pp candidato_current : list_candidatos) {
                                    if (candidato_current.getCargo() == 2) {
                            %>
                            <tr>
                                <th scope="row"><%=contador_temp++%></th>
                                <td><img src="<%=candidato_current.getImagen()%>" class="img-fluid" alt="imagen <%=candidato_current.getNombre()%>" style="padding:5px; width:90px;"></td>
                                <td><%=candidato_current.getNombre()%></td>
                                <td><%=candidato_current.getDepart_cadena()%></td>
                                <td><%=candidato_current.getMuni_cadena()%></td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>
                                        <form action="delete_candidato" method="post">
                                             <div class="col-sm-10" style="display:none;">
                                                 <input type="text" class="form-control" name="candidato_id"
                                                        value="<%=candidato_current.getId()%>">
                                             </div>
                                             <button type="submit" class="btn btn-danger">Eliminar</button>    
                                         </form>
                                    </div>
                                </td>
                            </tr>
                            <%}
                                    contador++;
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>         
            <br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-4" style="padding:0px;">
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#alcalde_modal">Agregar Candidato Alcalde</button>
                </div>
            </div>
            <br><br>
            <div class="row justify-content-center">
                <div class="card col-6 col-md-6" style="padding:0px;">
                    <br>
                    <h4 style="text-align: center;">Candidatos a Diputados</h4>
                    <br>
                    <table class="table" style="text-align: center;">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Imagen</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Departamento</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                list_candidatos = (ArrayList<Candidato_pp>) request.getAttribute("candidatos_pp");
                                contador_dipu = 1;
                                for (Candidato_pp candidato_current : list_candidatos) {
                                    if (candidato_current.getCargo() == 3) {
                            %>
                            <tr>
                                <th scope="row"><%=contador_dipu++%></th>
                                <td><img src="<%=candidato_current.getImagen()%>" class="img-fluid" alt="Imagen <%=candidato_current.getNombre()%>" style="padding:5px; width:90px;"></td>
                                <td><%=candidato_current.getNombre()%></td>
                                <td><%=candidato_current.getDepart_cadena()%></td>
                                <td>
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>
                                        <form action="delete_candidato" method="post">
                                             <div class="col-sm-10" style="display:none;">
                                                 <input type="text" class="form-control" name="candidato_id"
                                                        value="<%=candidato_current.getId()%>">
                                             </div>
                                             <button type="submit" class="btn btn-danger">Eliminar</button>    
                                         </form>
                                    </div>
                                </td>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
                </div>                    
            </div>
            <br>
            <div class="row justify-content-center">
                <div class="card col-12 col-md-4" style="padding:0px;">
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#dipu_modal">Agregar Candidato Dipitado</button>
                </div>
            </div>
            <br><br><br><br>
        </div>
        <div class="modal fade" id="alcalde_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo Candidato Alcalde</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="procesar_alcalde.jsp" method="post" enctype="MULTIPART/FORM-DATA">
                            <div class="form-group row">
                                <label for="inputPPname" class="col-sm-2 col-form-label">Nombre: </label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPPname" name="candidato_nombre">
                                    <br>
                                </div>
                                
                                <label for="imagen" class="col-sm-2 col-form-label">Imagen: </label>
                                 <div class="col-sm-10">
                                     <input type="file" name="archivo" value="" />
                                     <br>
                                     <br>
                                 </div>                                 
                                
                                <div id="div_muni" class="input-group mb-3 col-sm-12">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="select_muni">Municipio</label>
                                    </div>
                                    <select class="custom-select" id="select_muni" name="municipio">
                                        <option value="0" disabled >Seleccione un Municipio</option>
                                        <%
                                            list_muni = (ArrayList<Municipio>) request.getAttribute("list_muni");
                                            session.setAttribute("list_muni", list_muni);
                                            for (Municipio municipio_current : list_muni) {
                                        %>
                                        <option value="<%=municipio_current.getId()%>"><%=municipio_current.getNombre()%></option>
                                        <%}%>
                                    </select>
                                </div>                                    
                                <div class="col-sm-10" style="display:none;">
                                    <input type="number" class="form-control" name="id_pp"
                                           value="<%=request.getAttribute("id_pp")%>">
                                </div>
                            </div>
                            <div class="col-sm-10" style="display:none;">
                                <input type="number" class="form-control" name="id"
                                       value="<%=contador++%>">
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

        <div class="modal fade" id="dipu_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo Candidato Diputado</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="procesar_diputado.jsp" method="post" enctype="MULTIPART/FORM-DATA">
                            <div class="form-group row">
                                <label for="inputPPname" class="col-sm-2 col-form-label">Nombre: </label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPPname" name="candidato_nombre">
                                    <br>
                                </div>
                                <label for="imagen" class="col-sm-2 col-form-label">Imagen: </label>
                                 <div class="col-sm-10">
                                     <input type="file" name="archivo" value="" />
                                     <br>
                                     <br>
                                 </div>
                                <div id="div_dep" class="input-group mb-3 col-sm-12">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="select_depart">Departamento</label>
                                    </div>
                                    <select class="custom-select" id="select_depart" name="departamento">
                                        <option value="0" disabled >Seleccione un departamento</option>
                                        <%
                                            list_dep = (ArrayList<Departamento>) request.getAttribute("list_dep");
                                            request.setAttribute("list_dep", list_dep);
                                            for (Departamento departamento_current : list_dep) {
                                        %>
                                        <option value="<%=departamento_current.getId()%>"><%=departamento_current.getNombre()%></option>
                                        <%}%>
                                    </select>
                                </div>                                                                  
                                <div class="col-sm-10" style="display:none;">
                                    <input type="number" class="form-control" name="id_pp"
                                           value="<%=request.getAttribute("id_pp")%>">
                                </div>
                            </div>
                            <div class="col-sm-10" style="display:none;">
                                <input type="number" class="form-control" name="id"
                                       value="<%=contador++%>">
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

        <div class="modal fade" id="presi_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo Candidato Presidente</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="procesar_presi.jsp" method="post" enctype="MULTIPART/FORM-DATA">
                            <div class="form-group row">
                                <label for="inputPPname" class="col-sm-2 col-form-label">Nombre: </label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputPPname" name="candidato_nombre">
                                    <br>
                                </div>
                                <label for="imagen" class="col-sm-2 col-form-label">Imagen: </label>
                                 <div class="col-sm-10">
                                     <input type="file" name="archivo" value="" />
                                     <br>
                                 </div>
                                <div class="col-sm-10" style="display:none;">
                                    <input type="number" class="form-control" name="id_pp"
                                           value="<%=request.getAttribute("id_pp")%>">
                                </div>
                            </div>
                            <div class="col-sm-10" style="display:none;">
                                <input type="number" class="form-control" name="id"
                                       value="<%=contador++%>">
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
