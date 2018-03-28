<%-- 
    Document   : index
    Created on : 13-mar-2018, 4:31:04
    Author     : alex
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
            <a class="navbar-brand" href="#">Sistema Electoral</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                </ul>
            </div>
        </nav>
        <br><br>  
        <div class="container">
            <div class="row justify-content-center">
                <div class="card col-12 col-md-6" style="padding:0px;">
                    <h5 class="card-header">Sistema Electoral</h5>
                    <form action="login" method="post">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="exampleInputEmail1">ID de usuario</label>
                                <input type="text" class="form-control" name="user_id" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Ingresa tu ID" required>
                                <small id="emailHelp" class="form-text text-muted">We'll never share your ID with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Contraseña</label>
                                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Ingresa tu contraseña" name="pass" required>
                            </div>                                                                            
                        </div>
                        <div class="input-group mb-3 col-sm-12">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="role">Role de Usuario</label>
                            </div>
                            <select class="custom-select" id="role" name="role">
                                <option value="0" disabled >Seleccione un Role</option>
                                <option value="3">Administrador de Sistema</option>
                                <option value="1">Elector</option>
                                <option value="2">Magistrado</option>
                                <option value="4">Miembro de Mesa Electoral</option>
                            </select>
                            <br>
                        </div>
                        <br>
                        <div class="row justify-content-center">
                            <button type="submit" class="btn btn-success col-6">Iniciar Sesion</button>
                        </div>
                    </form>
                    <br>
                </div>
            </div>                
    </div>
</div>

</body>
</html>