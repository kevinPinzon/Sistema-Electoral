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
public class Miembro {
    
    private int id;
    private String nombre;
    private String pass;
    private int id_mesa;
    private int cargo;
    private String cargo_cadena;

    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String passw = "1234";
    
    private static Connection con = null;
    
    public static Miembro login_miembro(int user_id, String pass){
        String sql_login = "select * from MIEMBRO_MESA where ID=?";
        Miembro temp = new Miembro();
        temp.setId(0);
        temp.setPass(".");
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_login);
            ps.setInt(1, user_id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                if (rs.getString(2).equals(pass)) {                    
                    temp.setId(rs.getInt(1));
                    temp.setPass(rs.getString(2));
                    temp.setNombre(rs.getString(3));
                    temp.setId_mesa(rs.getInt(4));
                    temp.setCargo(rs.getInt(5));
                    return temp;
                }
            }
        con.close();
        }catch(Exception e){
            e.printStackTrace();
            temp.setNombre(e.getMessage());
            return temp;
        }
        if (temp.getId() != 0) {
            if (temp.getPass().equals(".")) {
                temp.setNombre("Contraseña Inconrrecta");
            }
        }else{
            temp.setNombre("Usuario No Encontrado");
        }
        return temp;
    } 
    
    public static String insertar(int id_param,String pass_param,String nombre_param, int mesa_param,int cargo_param){
        String sql= "insert into MIEMBRO_MESA values(?,?,?,?,?)";
        int result = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id_param);//id
            pr.setString(2, pass_param);//pass
            pr.setString(3, nombre_param);//nombre
            pr.setInt(4, mesa_param);//id_mesa            
            pr.setInt(5, cargo_param);//cargo
            
            result = pr.executeUpdate();    
            con.close();
        }catch(Exception e){
            return e.getMessage();
        }
        return "insert";
    }
    
    public static List<Miembro> getAllMiembros(int id_mesa ){
        List <Miembro> list_miembros = new ArrayList<Miembro>();
        String sql_list = "select * from MIEMBRO_MESA where ID_MESA=? ORDER BY CARGO DESC";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, id_mesa);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Miembro temp = new Miembro();
                temp.setId(rs.getInt(1));
                temp.setPass(rs.getString(2));
                temp.setNombre(rs.getString(3));
                temp.setId_mesa(rs.getInt(4));
                temp.setCargo(rs.getInt(5));
            
                if (rs.getInt(5) == 3) {
                    temp.setCargo_cadena("Presidente");
                }else if (rs.getInt(5) == 2) {
                    temp.setCargo_cadena("Secretario");
                }else{
                    temp.setCargo_cadena("Vocal");
                }
                list_miembros.add(temp);
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list_miembros;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public int getId_mesa() {
        return id_mesa;
    }

    public void setId_mesa(int id_mesa) {
        this.id_mesa = id_mesa;
    }

    public int getCargo() {
        return cargo;
    }

    public void setCargo(int cargo) {
        this.cargo = cargo;
    }

    public String getCargo_cadena() {
        return cargo_cadena;
    }

    public void setCargo_cadena(String cargo_cadena) {
        this.cargo_cadena = cargo_cadena;
    }

    public void getAllMiembros() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
