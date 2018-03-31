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
public class Elector {

    private String id;
    private String nombre;
    private String pass;
    private int id_me;
    private int estado;
    private String estado_cadena;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String passw = "1234";
    
    private static Connection con = null;

    public static String insertar(String id_param,String pass_param,String nombre_param, int mesa_param){
        String sql= "insert into ELECTOR values(?,?,?,?,?)";
        int result = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setString(1, id_param);//id
            pr.setString(2, pass_param);//pass
            pr.setString(3, nombre_param);//nombre
            pr.setInt(4, mesa_param);//id_mesa            
            pr.setInt(5, 1);//cargo
            
            result = pr.executeUpdate();    
            con.close();
        }catch(Exception e){
            return e.getMessage();
        }
        return "insert";
    }
    
    public static List<Elector> getAllElectores(int id_mesa ){
        List <Elector> list_electores = new ArrayList<Elector>();
        String sql_list = "select * from ELECTOR where ID_ME=?";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, id_mesa);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Elector temp = new Elector();
                temp.setId(rs.getString(1));
                temp.setPass(rs.getString(2));
                temp.setNombre(rs.getString(3));
                temp.setId_me(rs.getInt(4));
                temp.setEstado(rs.getInt(5));
            
                if (rs.getInt(5) == 3) {
                    temp.setEstado_cadena("Ya Voto");
                }else if (rs.getInt(5) == 2) {
                    temp.setEstado_cadena("Habilitado");
                }else{
                    temp.setEstado_cadena("Inhabilitado");
                }
                list_electores.add(temp);
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list_electores;
    }
    
        public static Elector login_elector(String user_id, String pass){
        String sql_login = "select * from Elector where ID=?";
        Elector temp = new Elector();
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
    
    public String getEstado_cadena() {
        return estado_cadena;
    }

    public void setEstado_cadena(String estado_cadena) {
        this.estado_cadena = estado_cadena;
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

    public int getId_me() {
        return id_me;
    }

    public void setId_me(int id_me) {
        this.id_me = id_me;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
    
    
}
