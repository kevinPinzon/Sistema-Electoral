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
public class Conteo {
    
    private int id;
    private int id_resultado;
    private int id_candidato;
    private int cuenta;

    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String passw = "1234";
    
    private static Connection con = null;

    public static int insertar(int id_param,int id_resultado_param,int id_candidato_param){
        String sql= "insert into CONTEO values(?,?,?,?)";
        int result = 0;
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            
            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id_param);//id
            pr.setInt(2, id_resultado_param);//resultado
            pr.setInt(3, id_candidato_param);//candidato
            pr.setInt(4, 1);//cuenta
            
            result = pr.executeUpdate();    
            con.close();
        }catch(Exception e){
            //return e.getMessage();
        }
        return result;
    }
    
    public static List<Conteo> getCuentas(int id_resultado){
        List <Conteo> list = new ArrayList<Conteo>();
        String sql_list = "select * from CONTEO where ID_RESULTADO=? ORDER BY CUENTA ASC";

        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_list);            
            ps.setInt(1, id_resultado);//mesa electoral            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                Conteo temp = new Conteo();
                temp.setId(rs.getInt(1));
                temp.setId_resultado(rs.getInt(2));
                temp.setId_candidato(rs.getInt(3));
                temp.setCuenta(rs.getInt(4));
                
                list.add(temp);
            }
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public static Conteo buscar_conteo(int id_resultado_param, int id_candidato_param){
        String sql= "select * from CONTEO where ID_RESULTADO=?";
        Conteo conteo = new Conteo();
        conteo.setId(0);
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql);            
            ps.setInt(1, id_resultado_param);//mesa electoral
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                if (id_candidato_param == rs.getInt(3)) {
                    conteo.setId(rs.getInt(1));
                    conteo.setCuenta(rs.getInt(4));
                }
            }
            con.close();
        }catch(Exception e){
            conteo.setId(0);
        }
        return conteo;
    }

    public static int sumar_voto(int id_param,int conteo){
        int status = 0;
        String sql_list= "update CONTEO set CUENTA=? where ID=?";
        
        try{
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, passw);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, conteo);
            ps.setInt(2, id_param);
            
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

    public int getId_resultado() {
        return id_resultado;
    }

    public void setId_resultado(int id_resultado) {
        this.id_resultado = id_resultado;
    }

    public int getId_candidato() {
        return id_candidato;
    }

    public void setId_candidato(int id_candidato) {
        this.id_candidato = id_candidato;
    }

    public int getCuenta() {
        return cuenta;
    }

    public void setCuenta(int cuenta) {
        this.cuenta = cuenta;
    }
    
    
}
