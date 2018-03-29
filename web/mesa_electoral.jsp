<%-- 
    Document   : mesa_electoral
    Created on : 06-mar-2018, 0:47:22
    Author     : alexanderpinzon
--%>
<%@page import="Modelos.Admin"%>
<%@page import="Modelos.Mesa_Electoral"%>
<%@page import="Modelos.Municipio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    Admin admin = new Admin();
    List<Municipio> list_muni = new ArrayList<Municipio>();
    List<Mesa_Electoral> list_me = new ArrayList<Mesa_Electoral>();
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
             <h1 style="text-align: center;">Mesas Electorales</h1>
             <br>
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-8" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Codigo</th>
                                 <th scope="col">Departamento</th>
                                 <th scope="col">Municipio</th>
                                 <th scope="col">Estado de Votacion</th>                                 
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                             <%
                                 list_me = (ArrayList<Mesa_Electoral>)session.getAttribute("list_me");
                                 contador = 1;
                                 for (Mesa_Electoral me_current : list_me){
                             %>
                             <tr>
                                <form action="cargar_mesa_electoral_detalles" method="post">
                                    <th scope="row"><%= contador++%>
                                    </th>
                                    <td><%=me_current.getId()%></td>
                                    <td><%=me_current.getDepartamento_cadena()%></td>
                                    <td><%=me_current.getMunicipio_cadena()%></td>
                                    <td><%=me_current.getEstado_cadena()%></td>                                 
                                    <td>
                                        <div class="col-sm-10" style="display:none;">
                                            <input type="number" class="form-control" name="me_id" value="<%=me_current.getId()%>">
                                        </div>
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <button type="submit" class="btn btn-success">Ver Mas</button>    
                                        </div>
                                    </td>
                                 </form>
                             </tr>                         
                             <%}%>
                         </tbody>
                     </table>
                 </div>
             </div>              
             <br><br>  
             <div class="row justify-content-center">
                 <div class="card col-6 col-md-3" style="padding:0px;">
                     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#exampleModal">Agregrar Nueva Mesa</button>
                 </div>
                 
             </div>
        </div>
         
         <div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
             <div class="modal-dialog modal-lg" role="document">
                 <div class="modal-content">
                     <div class="modal-header">
                         <h5 class="modal-title" id="exampleModalLabel">Nueva Mesa Electoral</h5>
                         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                             <span aria-hidden="true">&times;</span>
                         </button>
                     </div>
                     <div class="modal-body">
                         <form action="agregar_mesa_electoral" method="post">
                            <div class="form-group row">
                                <div id="div_muni" class="input-group mb-3 col-sm-12">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="select_muni">Municipio</label>
                                    </div>
                                    <select class="custom-select" id="select_muni" name="id_municipio">
                                        <option value="0" disabled >Seleccione un Municipio</option>
                                        <%
                                            list_muni = (ArrayList<Municipio>) session.getAttribute("list_muni");
                                            for (Municipio municipio_current : list_muni) {
                                        %>
                                        <option value="<%=municipio_current.getId()%>"><%=municipio_current.getNombre()%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <label for="lugar_nombre" class="col-sm-4 col-form-label">Nombre del lugar: </label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="lugar_nombre" name="lugar_nombre">
                                    <br>
                                </div>
                                <label for="lugar_descripcion" class="col-sm-4 col-form-label">Descripcion del lugar: </label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="lugar_descripcion" name="lugar_descripcion">
                                    <br>
                                </div>
                            </div>
                            <div class="col-sm-10" style="display:none;">
                                <input type="number" class="form-control" name="me_id"
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
