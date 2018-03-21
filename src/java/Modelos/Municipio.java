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
public class Municipio {
    
    private String nombre;
    private int id;
    private int id_dep;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";
    
    private static Connection con = null;
    
    public static List<Municipio> getAllMunicipios() {
        List<Municipio> list_departamentos = new ArrayList<Municipio>();
        String sql_list = "select * from Municipio";

        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Municipio temp = new Municipio();
                temp.setId(rs.getInt(1));
                temp.setNombre(rs.getString(2));
                temp.setId_dep(rs.getInt(3));
                
                list_departamentos.add(temp);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list_departamentos;
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

    public int getId_dep() {
        return id_dep;
    }

    public void setId_dep(int id_dep) {
        this.id_dep = id_dep;
    }    
}
