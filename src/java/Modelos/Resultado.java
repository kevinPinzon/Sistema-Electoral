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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author alex
 */
public class Resultado {
    private int id;
    private int id_me;
    private int cargo;
    private int municipio;
    private int departamento;

    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String passw = "1234";
    
    private static Connection con = null;
    
    public static String insertar(int id_param,int id_me_param,int cargo,int departamento_param,int municipio_param){
        String sql= "insert into RESULTADO values(?,?,?,?,?)";
        String result = "0";
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id_param);//id
            pr.setInt(2, id_me_param);//mesa electoral
            pr.setInt(3, cargo);//cargo
            pr.setInt(4, departamento_param);//departamento            
            pr.setInt(5, municipio_param);//municipio
            
            result = pr.executeUpdate()+" excelente";
            con.close();
        }catch(Exception e){
            return "cagaste porque: "+e.getMessage();
        }
        return result;
    }
    
    public static Resultado buscar_resultado(int id_me_param, int cargo,int departamento_param,int municipio_param){
        String sql= "select * from RESULTADO where ID_ME=?";
        Resultado resultado = new Resultado();
        resultado.setId(0);
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql);            
            ps.setInt(1, id_me_param);//mesa electoral
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                if (cargo == 1 && rs.getInt(3) == 1) {
                    resultado.setId(rs.getInt(1));
                    resultado.setId_me(rs.getInt(2));
                    resultado.setCargo(rs.getInt(3));
                    resultado.setDepartamento(rs.getInt(4));
                    resultado.setMunicipio(rs.getInt(5));
                    return resultado;
                }else if (cargo == 3 && rs.getInt(3) == 3) {
                    if (departamento_param == rs.getInt(4)) {
                        resultado.setId(rs.getInt(1));
                        resultado.setId_me(rs.getInt(2));
                        resultado.setCargo(rs.getInt(3));
                        resultado.setDepartamento(rs.getInt(4));
                        resultado.setMunicipio(rs.getInt(5));
                        return resultado;
                    }
                }else if (cargo == 2 && rs.getInt(3) == 2) {
                    if (municipio_param == rs.getInt(5)) {
                        resultado.setId(rs.getInt(1));
                        resultado.setId_me(rs.getInt(2));
                        resultado.setCargo(rs.getInt(3));
                        resultado.setDepartamento(rs.getInt(4));
                        resultado.setMunicipio(rs.getInt(5));
                        return resultado;
                    }
                }
            }
            con.close();
        }catch(Exception e){
            resultado.setId(0);
        }
        return resultado;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_me() {
        return id_me;
    }

    public void setId_me(int id_me) {
        this.id_me = id_me;
    }

    public int getCargo() {
        return cargo;
    }

    public void setCargo(int cargo) {
        this.cargo = cargo;
    }

    public int getMunicipio() {
        return municipio;
    }

    public void setMunicipio(int municipio) {
        this.municipio = municipio;
    }

    public int getDepartamento() {
        return departamento;
    }

    public void setDepartamento(int departamento) {
        this.departamento = departamento;
    }
    
    
}
