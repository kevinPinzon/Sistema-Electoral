<%-- 
    Document   : lista_electores_mesa_mm
    Created on : 06-mar-2018, 12:54:21
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
            <img class="card-img-top" src="https://image.flaticon.com/icons/png/512/281/281382.png" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
            <a class="navbar-brand" href="home_miembro_mesa.jsp">Sistema Electoral / Miembro de Mesa (###)</a>
            <img class="card-img-top" src="https://image.flaticon.com/icons/svg/145/145859.svg" alt="Card image cap" style="padding:5px; height:70px; width: 70px;">
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
                            <a class="dropdown-item" href="index.jsp">Cerrar Sesion</a>
                        </div>
                    </li>                    
                </ul>
            </div>
        </nav>
        <br><br>  
        <div class="container-fluid">

             <h1 style="text-align: center;">Electores Asignados</h1>
             <br>
             <div class="row justify-content-center">
                 <div class="card col-12 col-md-8" style="padding:0px;">
                     <table class="table" style="text-align: center;">
                         <thead class="thead-dark">
                             <tr>
                                 <th scope="col">No.</th>
                                 <th scope="col">Nombre </th>
                                 <th scope="col">Identidad</th>
                                 <th scope="col">Estado</th>
                                 <th scope="col">Acciones</th>
                             </tr>
                         </thead>
                         <tbody>
                             <tr>
                                 <th scope="row">1</th>
                                 <td>Valeria Castro</td>
                                 <td>3221 2000 29349</td>
                                 <td>No Habilitado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-success">Habilitar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">2</th>
                                 <td>Steph Amador</td>
                                 <td>1223 1983 22041</td>
                                 <td>Habilitado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-success" disabled>Habilitar</button>
                                     </div>
                                 </td>
                             </tr>
                             <tr>
                                 <th scope="row">3</th>
                                 <td>Angie Artica</td>
                                 <td>8871 1972 22332</td>
                                 <td>No Habilitado</td>
                                 <td>
                                     <div class="btn-group" role="group" aria-label="Basic example">
                                         <button type="button" class="btn btn-success">Habilitar</button>
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
                     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#exampleModal">Crear Elector</button>
                 </div>
             </div>
         </div>
    </body>
</html>
