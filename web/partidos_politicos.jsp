<%-- 
    Document   : partidos_politicos
    Created on : 05-mar-2018, 21:00:17
    Author     : alexanderpinzon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
         <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
             <a class="navbar-brand" href="home_admin.jsp">Sistema Electoral / Administrador de Sistema</a>
             <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                 <span class="navbar-toggler-icon"></span>
             </button>

             <div class="collapse navbar-collapse" id="navbarSupportedContent">
                 <ul class="navbar-nav mr-auto">
                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                             Username
                         </a>
                         <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                             <a class="dropdown-item" href="#">Mi Perfil</a>
                             <div class="dropdown-divider"></div>
                             <a class="dropdown-item" href="#">Cerrar Sesion</a>
                         </div>
                     </li>                    
                 </ul>
             </div>
         </nav>
         <br><br>  
         <div class="container-fluid">

             <h1 style="text-align: center;">Partidos Politicos</h1>
             <br>
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-8" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Nombre</th>
                                 <th scope="col">Miembros</th>
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                             <tr>
                                 <th scope="row">1</th>
                                 <td>Partido Rojo</td>
                                 <td>20</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-info">Ver Miembros</button>
                                         <button style="color:white;" type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal1">Editar</button>
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">2</th>
                                 <td>Partido Azul</td>
                                 <td>11</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-info">Ver Miembros</button>
                                         <button style="color:white;" type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal1">Editar</button>
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">3</th>
                                 <td>Partido Verde</td>
                                 <td>25</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-info">Ver Miembros</button>
                                         <button style="color:white;" type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal1">Editar</button>
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                         </tbody>
                     </table>
                 </div>
             </div>              
             <br><br>  
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-4" style="padding:0px;">
                     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#exampleModal">Crear Partido Politico</button>
                 </div>
             </div>
         </div>

         <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
             <div class="modal-dialog" role="document">
                 <div class="modal-content">
                     <div class="modal-header">
                         <h5 class="modal-title" id="exampleModalLabel">Nuevo Partido Politico</h5>
                         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                             <span aria-hidden="true">&times;</span>
                         </button>
                     </div>
                     <div class="modal-body">
                         <form>
                             <div class="form-group row">
                                 <label for="inputPassword" class="col-sm-2 col-form-label">Nombre: </label>
                                 <div class="col-sm-10">
                                     <input type="text" class="form-control" id="inputPassword">
                                 </div>
                             </div>
                         </form>
                     </div>
                     <div class="modal-footer">
                         <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                         <button type="button" class="btn btn-success">Guardar</button>
                     </div>
                 </div>
             </div>
         </div>

         <div class="modal fade bd-example-modal-lg" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
             <div class="modal-dialog modal-lg" role="document">
                 <div class="modal-content">
                     <div class="modal-header">
                         <h5 class="modal-title" id="exampleModalLabel">Editar Partido Politico</h5>
                         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                             <span aria-hidden="true">&times;</span>
                         </button>
                     </div>
                     <div class="modal-body">
                         <form>
                             <div class="form-group row">
                                 <label for="inputPassword" class="col-sm-2 col-form-label">Nombre: </label>
                                 <div class="col-sm-10">
                                     <input type="text" class="form-control" id="inputPassword">
                                 </div>
                             </div>
                         </form>
                         <div class="row justify-content-center">
                 <div class="card col-12 col-md-12" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Nombre</th>
                                 <th scope="col">Puesto</th>
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                             <tr>
                                 <th scope="row">1</th>
                                 <td>Partido Rojo</td>
                                 <td>Gabriela Castillo</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">2</th>
                                 <td>Michelle Amador</td>
                                 <td>Diputado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">3</th>
                                 <td>Marjorie Games</td>
                                 <td>Alcalde</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                         </tbody>
                     </table>
                 </div>
             </div>
                     </div>
                     <div class="modal-footer">
                         <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                         <button type="button" class="btn btn-info" >Agregar Nuevo Candidato</button>
                         <button type="button" class="btn btn-success">Actualizar</button>
                     </div>
                 </div>
             </div>
         </div>

     </body>
</html>
