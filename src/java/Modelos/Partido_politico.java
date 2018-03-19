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
import java.sql.Statement;
import java.util.*;

/**
 *
 * @author alex
 */
public class Partido_politico {
    private int id;
    private String nombre;
    private int cout_miembros;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";
    
    private static Connection con = null;
    private static PreparedStatement pr = null;
    private static ResultSet rs = null;
   // private Statement stmt = null;
    
    public static int insertar(int id,String nombre){
        String sql= "insert into PARTIDO_POLITICO values(?,?)";
        int status = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            
            pr = con.prepareStatement(sql);
            pr.setInt(1, id);
            pr.setString(2, nombre);
            status = pr.executeUpdate();
            con.close();
            
        }catch(Exception e){
            return status;
        }
        return status;
    }
    
    public static List<Partido_politico> getAllPartidosp(){
        List <Partido_politico> list_pp = new ArrayList<Partido_politico>();
        String sql_list= "select * from PARTIDO_POLITICO";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Partido_politico temp = new Partido_politico();
                temp.setId(rs.getInt(1));
                temp.setNombre(rs.getString(2));
                list_pp.add(temp);
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list_pp;
    }
    
    public static int update(String name,int id){
        int status = 0;
        String sql_list= "update PARTIDO_POLITICO set nombre=? where id=?";
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setString(1, name);
            ps.setInt(2, id);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
    public static int delete(int id){
        int status = 0;
        String sql_list= "delete PARTIDO_POLITICO where id=?";
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);            
            ps.setInt(1, id);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public int getCount_miembros() {
        return cout_miembros;
    }

    public void setCount_miembros(int count) {
        this.cout_miembros = count;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
}
