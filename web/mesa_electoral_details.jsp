<%-- 
    Document   : mesa_electoral
    Created on : 06-mar-2018, 0:14:12
    Author     : alexanderpinzon
--%>
<%@page import="Modelos.Admin"%>
<%@page import="Modelos.Miembro"%>
<%@page import="Modelos.Mesa_Electoral"%>
<%@page import="Modelos.Municipio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Mesa_Electoral mesa_electoral = new Mesa_Electoral();
    List<Miembro> list_miembro = new ArrayList<Miembro>();
    private int contador = 0;
    private boolean have_presi,have_secre;
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
             <%
                 mesa_electoral = (Mesa_Electoral)session.getAttribute("mesa_electora_current");
             %>
             <h1 style="text-align: center;">Miembros de Mesa Electoral (<%=mesa_electoral.getId()%>)</h1>
             <br>
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-8" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Nombre</th>
                                 <th scope="col">Num. Credencial</th>
                                 <th scope="col">Cargo</th>
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                            <%
                                have_presi = false;
                                have_secre = false;
                                contador = 1;
                                list_miembro = (ArrayList<Miembro>) session.getAttribute("miembros_current");
                                for (Miembro miembro_current : list_miembro) {
                                    if (miembro_current.getCargo() == 3) {
                                        have_presi = true;
                                    } else if (miembro_current.getCargo() == 2) {
                                        have_secre = true;
                                    }
                            %>
                            <tr>
                                <th scope="row"><%=contador++%></th>
                                <td><%=miembro_current.getNombre()%></td>
                                <td><%=miembro_current.getId()%></td>
                                <td><%=miembro_current.getCargo_cadena()%></td>
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
                 <div class="card col-6 col-md-3" style="padding:0px;">
                     <a href="cargar_electores" class="btn btn-success btn-lg">Ver Electores</a>
                 </div>
                 <div class="card col-6 col-md-3" style="padding:0px;">
                     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#modal_nuevo_miembro">Agregrar Nuevo Miembro</button>
                 </div>
                 <div class="card col-6 col-md-3" style="padding:0px; color:white;">
                     <a style="color:white;" type="button" href="generar_reporte_mesa.jsp" class="btn btn-warning btn-lg" >Reporte de Mesa</a>
                 </div>
             </div>
             <br>
             <% 
                 if (mesa_electoral.getEstado() == 3) {
             %>
             <div class="row justify-content-center">
                 <div class="card col-6 col-md-3" style="padding:0px;">
                     <a href="generar_reporte_presi_mesa.jsp" class="btn btn-info btn-lg">Reporte de resultados presidencia</a>
                 </div>
                 <div class="card col-6 col-md-3" style="padding:0px;">
                     <a href="generar_reporte_alcalde_mesa.jsp" class="btn btn-info btn-lg">Reporte de resultados alcaldes</a>
                 </div>
                 <div class="card col-6 col-md-3" style="padding:0px;">
                     <a href="generar_reporte_diputados_mesa.jsp" class="btn btn-info btn-lg">Reporte de resultados diputados</a>
                 </div>                 
             </div>    
             <br>
             <% }
             %>
        </div>
             
         <div class="modal fade" id="modal_nuevo_miembro" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
             <div class="modal-dialog" role="document">
                 <div class="modal-content">
                     <div class="modal-header">
                         <h5 class="modal-title" id="exampleModalLabel">Nueva Miembro de Mesa</h5>
                         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                             <span aria-hidden="true">&times;</span>
                         </button>
                     </div>
                     <div class="modal-body">
                         <form action="agregar_miembro" method="post">
                            <div class="form-group row">
                                <div class="col-sm-10" style="display:none;">
                                    <input type="number" id="id_mm" class="form-control" name="id_mm" value="<%=contador++%>">
                                <br>
                                </div>
                                
                                <label for="nombre_mm" class="col-sm-4 col-form-label">Nombre: </label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="nombre_mm" name="nombre_mm" required>                                    
                                <br>
                                </div>
                                
                                <label for="pass" class="col-sm-4 col-form-label">Contraseña </label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="pass" name="pass" required>
                                <br>
                                </div>
                                
                                <div id="div_muni" class="input-group mb-3 col-sm-12">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="cargo">Cargo</label>
                                    </div>
                                    <select class="custom-select" id="cargo" name="cargo">
                                        <option value="0" disabled >Seleccione un Cargo</option>
                                        <option value="1">Vocal</option>
                                        <% if (!have_presi) {%>
                                        <option value="3">Presidente</option>
                                        <%}%>
                                        <% if (!have_secre) {%>
                                        <option value="2">Secretario</option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-10" style="display:none;">
                                <input type="number" class="form-control" name="me_id"
                                       value="<%=mesa_electoral.getId()%>">
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
