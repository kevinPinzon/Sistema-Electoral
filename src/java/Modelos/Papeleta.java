/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author alex
 */
public class Papeleta {
    
    private int id;
    private int id_candidato;
    private int posicion;
    private int cargo;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";
    
    private static Connection con = null;
    private static PreparedStatement pr = null;
    private static ResultSet rs = null;

    public static int insertar(int id,int id_candidato, int cargo,int posicion){
        String sql= "insert into PAPELETA values(?,?,?,?)";
        int status = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id);
            pr.setInt(2, id_candidato);
            pr.setInt(3, cargo);
            pr.setInt(5, posicion);
            
            status = pr.executeUpdate();    
            con.close();
            
        }catch(Exception e){
            return status;
        }
        return status;
    }    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_candidato() {
        return id_candidato;
    }

    public void setId_candidato(int id_candidato) {
        this.id_candidato = id_candidato;
    }

    public int getPosicion() {
        return posicion;
    }

    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }

    public int getCargo() {
        return cargo;
    }

    public void setCargo(int cargo) {
        this.cargo = cargo;
    }
    
    
    
}
