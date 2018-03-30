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
public class Candidato_pp {
    private String nombre;
    private String imagen;
    private int id;
    private int partido_id;
    private int cargo;
    private int depart_id;
    private int muni_id;
    private String cargo_cadena;
    private String depart_cadena;
    private String muni_cadena;
    private String partido_nombre;
    private int posicion;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";
    
    private static Connection con = null;
    private static PreparedStatement pr = null;
    private static ResultSet rs = null;
    
    public static List<Candidato_pp> getAllCandidatos(int id_pp) {
        List<Candidato_pp> list_candidatos = new ArrayList<Candidato_pp>();
        String sql_list = "select * from CANDIDATO_PP where ID_PP=?";

        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, id_pp);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Candidato_pp temp = new Candidato_pp();
                temp.setId(rs.getInt(1));
                temp.setNombre(rs.getString(2));
                temp.setCargo(rs.getInt(3));
                temp.setPartido_id(rs.getInt(4));
                temp.setDepart_id(rs.getInt(5));
                temp.setMuni_id(rs.getInt(6));
                temp.setImagen(rs.getString(7));
                
                if (temp.getCargo() == 3) {//diputado
                    String sql_list2 = "select * from DEPARTAMENTO where ID=?";
                    PreparedStatement ps2 = con.prepareStatement(sql_list2);
                    ps2.setInt(1, temp.getDepart_id());
                    ResultSet rs2 = ps2.executeQuery();
                    while (rs2.next()) {
                        temp.setDepart_cadena(rs2.getString(2));
                    }                    
                }else if (temp.getCargo() == 2) {//alcalde
                    String sql_list2 = "select * from DEPARTAMENTO where ID=?";
                    PreparedStatement ps2 = con.prepareStatement(sql_list2);
                    ps2.setInt(1, temp.getDepart_id());
                    ResultSet rs2 = ps2.executeQuery();
                    while (rs2.next()) {
                        temp.setDepart_cadena(rs2.getString(2));
                    }
                    String sql_list3 = "select * from MUNICIPIO where ID=?";
                    PreparedStatement ps3 = con.prepareStatement(sql_list3);
                    ps3.setInt(1, temp.getMuni_id());
                    ResultSet rs3 = ps3.executeQuery();
                    while (rs3.next()) {
                        temp.setMuni_cadena(rs3.getString(2));
                    }
                }
                
                list_candidatos.add(temp);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list_candidatos;
    }
    
    public static List<Candidato_pp> getCandidatos_por_posicion(int cargo) {
        List<Candidato_pp> list_candidatos = new ArrayList<Candidato_pp>();
        String sql_list = "select * from CANDIDATO_PP where CARGO=?";

        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, cargo);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Candidato_pp temp = new Candidato_pp();
                temp.setId(rs.getInt(1));
                temp.setNombre(rs.getString(2));
                temp.setCargo(rs.getInt(3));
                temp.setPartido_id(rs.getInt(4));
                temp.setDepart_id(rs.getInt(5));
                temp.setMuni_id(rs.getInt(6));
                temp.setImagen(rs.getString(7));
                
                if (temp.getCargo() == 3) {//diputado
                    String sql_list2 = "select * from DEPARTAMENTO where ID=?";
                    PreparedStatement ps2 = con.prepareStatement(sql_list2);
                    ps2.setInt(1, temp.getDepart_id());
                    ResultSet rs2 = ps2.executeQuery();
                    while (rs2.next()) {
                        temp.setDepart_cadena(rs2.getString(2));
                    }                    
                }else if (temp.getCargo() == 2) {//alcalde
                    String sql_list2 = "select * from DEPARTAMENTO where ID=?";
                    PreparedStatement ps2 = con.prepareStatement(sql_list2);
                    ps2.setInt(1, temp.getDepart_id());
                    ResultSet rs2 = ps2.executeQuery();
                    while (rs2.next()) {
                        temp.setDepart_cadena(rs2.getString(2));
                    }
                    String sql_list3 = "select * from MUNICIPIO where ID=?";
                    PreparedStatement ps3 = con.prepareStatement(sql_list3);
                    ps3.setInt(1, temp.getMuni_id());
                    ResultSet rs3 = ps3.executeQuery();
                    while (rs3.next()) {
                        temp.setMuni_cadena(rs3.getString(2));
                    }
                }
                
                list_candidatos.add(temp);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list_candidatos;
    }

    public static int insertar(int id,int id_pp,int cargo,int id_dep,int id_muni,String nombre,String imagen){
        String sql= "insert into CANDIDATO_PP values(?,?,?,?,?,?,?)";
        int status = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id);
            pr.setString(2, nombre);
            pr.setInt(3, cargo);
            pr.setInt(4, id_pp);
            pr.setInt(5, id_dep);
            pr.setInt(6, id_muni);
            pr.setString(7, imagen);
            
            status = pr.executeUpdate();    
            con.close();
            
        }catch(Exception e){
            return status;
        }
        return status;
    }
    
    public static int delete(int id){
        int status = 0;
        String sql_list= "delete CANDIDATO_PP where id=?";
        
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
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPartido_id() {
        return partido_id;
    }

    public void setPartido_id(int partido_id) {
        this.partido_id = partido_id;
    }

    public int getCargo() {
        return cargo;
    }

    public void setCargo(int cargo) {
        this.cargo = cargo;
    }

    public int getDepart_id() {
        return depart_id;
    }

    public void setDepart_id(int depart_id) {
        this.depart_id = depart_id;
    }

    public String getDepart_cadena() {
        return depart_cadena;
    }

    public void setDepart_cadena(String depart_cadena) {
        this.depart_cadena = depart_cadena;
    }

    public String getMuni_cadena() {
        return muni_cadena;
    }

    public void setMuni_cadena(String muni_cadena) {
        this.muni_cadena = muni_cadena;
    }

    public int getMuni_id() {
        return muni_id;
    }

    public void setMuni_id(int muni_id) {
        this.muni_id = muni_id;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getPartido_nombre() {
        return partido_nombre;
    }

    public void setPartido_nombre(String partido_nombre) {
        this.partido_nombre = partido_nombre;
    }

    public int getPosicion() {
        return posicion;
    }

    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }
    
    
    
}
