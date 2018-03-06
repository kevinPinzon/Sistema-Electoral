<%-- 
    Document   : electores_por_mesa
    Created on : 06-mar-2018, 1:04:04
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

             <h1 style="text-align: center;">Electores (####)</h1>
             <br>
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-8" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Nombre</th>
                                 <th scope="col">Estado</th>
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                             <tr>
                                 <th scope="row">1</th>
                                 <td>Valeria Castro</td>
                                 <td>No ha votado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">2</th>
                                 <td>Steph Amador</td>
                                 <td>No ha votado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>
                                         <button type="button" class="btn btn-danger">Eliminar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">3</th>
                                 <td>Angie Artica</td>
                                 <td>No ha votado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button style="color:white;" type="button" class="btn btn-warning" >Editar</button>
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
                     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#exampleModal">Agregrar Elector</button>
                 </div>
             </div>
         </div>
    </body>
</html>
