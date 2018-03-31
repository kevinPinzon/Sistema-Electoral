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
public class Papeleta {
    
    private int id;
    private int id_candidato;
    private int posicion;
    private int cargo;
    private int id_municipio;
    private int id_depart;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";
    
    private static Connection con = null;
    private static PreparedStatement pr = null;
    private static ResultSet rs = null;

    public static int insertar(int id,int id_candidato, int cargo,int posicion,int municipio, int depa){
        String sql= "insert into PAPELETA values(?,?,?,?,?,?)";
        int status = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id);
            pr.setInt(2, id_candidato);
            pr.setInt(3, cargo);
            pr.setInt(4, posicion);
            pr.setInt(5, municipio);
            pr.setInt(6, depa);
            
            status = pr.executeUpdate();    
            con.close();
            
        }catch(Exception e){
            return status;
        }
        return status;
    }
    
    public static int update(int id_candidato,int posicion){
        int status = 0;
        String sql_list= "update PAPELETA set POSICION=? where ID_CANDIDAT0=?";
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, posicion);
            ps.setInt(2, id_candidato);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
    public static int delete(int id_candidato){
        int status = 0;
        String sql_list= "delete PAPELETA where ID_CANDIDATO=?";
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);            
            ps.setInt(1, id_candidato);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
    public static List<Papeleta> getAllPresidentes(int cargo ){
        List <Papeleta> candidatos = new ArrayList<Papeleta>();
        String sql_list = "select * from PAPELETA where CARGO=? ORDER BY POSICION ASC";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, cargo);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Papeleta temp = new Papeleta();
                temp.setId(rs.getInt(1));
                temp.setId_candidato(rs.getInt(2));
                temp.setCargo(rs.getInt(3));
                temp.setPosicion(rs.getInt(4));
                
                candidatos.add(temp);
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return candidatos;
    }
    
    public static List<Papeleta> getAllAlcaldes(int cargo, int municipio){
        List <Papeleta> candidatos = new ArrayList<Papeleta>();
        String sql_list = "select * from PAPELETA where CARGO=? ORDER BY POSICION ASC";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, cargo);
            ResultSet rs = ps.executeQuery();
            Papeleta temp;
            while(rs.next()){
                if (municipio == rs.getInt(5)) {
                    temp = new Papeleta();
                    temp.setId(rs.getInt(1));
                    temp.setId_candidato(rs.getInt(2));
                    temp.setCargo(rs.getInt(3));
                    temp.setPosicion(rs.getInt(4));
                    temp.setId_municipio(rs.getInt(5));

                    candidatos.add(temp);   
                }
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return candidatos;
    }
    
    public static List<Papeleta> getAllDiputado(int cargo, int departamento){
        List <Papeleta> candidatos = new ArrayList<Papeleta>();
        String sql_list = "select * from PAPELETA where CARGO=? ORDER BY POSICION ASC";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, cargo);
            ResultSet rs = ps.executeQuery();
            Papeleta temp;
            while(rs.next()){
                if (departamento == rs.getInt(5)) {
                    temp = new Papeleta();
                    temp.setId(rs.getInt(1));
                    temp.setId_candidato(rs.getInt(2));
                    temp.setCargo(rs.getInt(3));
                    temp.setPosicion(rs.getInt(4));
                    temp.setId_depart(rs.getInt(6));

                    candidatos.add(temp);   
                }
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return candidatos;
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

    public int getId_municipio() {
        return id_municipio;
    }

    public void setId_municipio(int id_municipio) {
        this.id_municipio = id_municipio;
    }

    public int getId_depart() {
        return id_depart;
    }

    public void setId_depart(int id_depart) {
        this.id_depart = id_depart;
    }
    
    
    
}
