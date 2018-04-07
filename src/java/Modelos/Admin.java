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
public class Admin {
    
    private String id;
    private String nombre;
    private String pass;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String passw = "1234";
    
    private static Connection con = null;

    public static Admin login_admin(String user_id, String pass){
        String sql_login = "select * from ADMIN where ID=?";
        Admin temp = new Admin();
        temp.setId("0");
        temp.setPass(".");
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_login);
            ps.setString(1, user_id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                if (rs.getString(2).equals(pass)) {                    
                    temp.setId(rs.getString(1));
                    temp.setPass(rs.getString(2));
                    temp.setNombre(rs.getString(3));                    
                    return temp;
                }
            }
        con.close();
        }catch(Exception e){
            e.printStackTrace();
            temp.setNombre(e.getMessage());
            return temp;
        }
        if (temp.getId() != "0") {
            if (temp.getPass().equals(".")) {
                temp.setNombre("Contraseña Inconrrecta");
            }
        }else{
            temp.setNombre("Usuario No Encontrado");
        }
        return temp;
    }
    
    public static List<Admin> getAllAdmins(){
        List <Admin> list_admins = new ArrayList<Admin>();
        String sql_list = "select * from ADMIN";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_list);

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Admin temp = new Admin();
                temp.setId(rs.getString(1));
                temp.setPass(rs.getString(2));
                temp.setNombre(rs.getString(3));
                list_admins.add(temp);
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list_admins;
    }
    
        public static String insertar(String id_param,String pass_param,String nombre_param){
        String sql= "insert into ADMIN values(?,?,?)";
        int result = 0;
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setString(1, id_param);//id
            pr.setString(2, pass_param);//pass
            pr.setString(3, nombre_param);//nombre
            
            result = pr.executeUpdate();    
            con.close();
        }catch(Exception e){
            return e.getMessage();
        }
        return "insert";
    }
        
    public static int delete(int id){
        int status = 0;
        String sql_list= "delete ADMIN where ID=?";
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_list);            
            ps.setInt(1, id);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
    
    
}
