<%-- 
    Document   : list_mesas_electorales_magistrado
    Created on : 06-abr-2018, 11:14:18
    Author     : alex
--%>

<%@page import="Modelos.Mesa_Electoral"%>
<%@page import="Modelos.Municipio"%>
<%@page import="Modelos.Magistrado"%>
<%@page import="Modelos.Departamento"%>
<%@page import="Modelos.Candidato_pp"%>
<%@page import="Modelos.Elector"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Magistrado magistrado = new Magistrado();
    List<Municipio> list_muni = new ArrayList<Municipio>();
    List<Mesa_Electoral> list_me = new ArrayList<Mesa_Electoral>();
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
             <h1 style="text-align: center;">Mesas Electorales</h1>
             <br>
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-10" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Codigo</th>
                                 <th scope="col">Departamento</th>
                                 <th scope="col">Municipio</th>
                                 <th scope="col">Estado de Votacion</th>
                                 <th scope="col">Estado de Acta</th>
                                 <th scope="col">Apertura</th>
                                 <th scope="col">Cierre</th>
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                             <%
                                 list_me = (ArrayList<Mesa_Electoral>)session.getAttribute("list_me");
                                 int contador = 1;
                                 for (Mesa_Electoral me_current : list_me){
                             %>
                             <tr>
                                    <th scope="row"><%= contador++%>
                                    </th>
                                    <td><%=me_current.getId()%></td>
                                    <td><%=me_current.getDepartamento_cadena()%></td>
                                    <td><%=me_current.getMunicipio_cadena()%></td>
                                    <td><%=me_current.getEstado_cadena()%></td>
                                    <td><%=me_current.getActa_estado_cadena()%></td>
                                    <%if (me_current.getEstado()==2) {%>
                                    <td><%=me_current.getApertura()%></td>
                                    <td></td>
                                    <%}else if (me_current.getEstado()==3) {%>
                                    <td><%=me_current.getApertura()%></td>
                                    <td><%=me_current.getCierre()%></td>
                                    <%}else {%>
                                    <td></td>
                                    <td></td>
                                    <%}%>
                                    <td>
                                        <%if (me_current.getEstado()==3) {%>
                                        <form action="generar_resultados_por_mesa_magistrado.jsp" method="post">
                                            <div class="col-sm-10" style="display:none;">
                                                <input type="number" class="form-control" name="me_id" value="<%=me_current.getId()%>">
                                            </div>
                                            <div class="btn-group" role="group" aria-label="Basic example">
                                                <button type="submit" class="btn btn-success">Generar Resultados</button>    
                                            </div>
                                        </form>
                                        <%}else {%>
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <button type="submit" class="btn btn-success" disabled>Generar Resultados</button>    
                                        </div>
                                        <%}%>
                                        <%if (me_current.getActa_estado() == 1) {%>
                                        <form action="anular_acta" method="post">
                                            <div class="col-sm-10" style="display:none;">
                                                <input type="number" class="form-control" name="me_id" value="<%=me_current.getId()%>">
                                            </div>
                                            <div class="btn-group" role="group" aria-label="Basic example">
                                                <button type="submit" class="btn btn-danger">Anular Acta</button>    
                                            </div>
                                        </form>      
                                        <%}else {%>
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <button type="submit" class="btn btn-danger" disabled>Anular Acta</button>    
                                        </div>
                                        <%}%>
                                    </td>
                             </tr>                         
                             <%}%>
                         </tbody>
                     </table>
                 </div>
             </div>              
             <br><br>
        </div>
    </body>
</html>
