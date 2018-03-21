/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author alex
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Departamento {
    
    private String nombre;
    private int id;
    private int num_dip;
    
    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";
    
    private static Connection con = null;
    private static PreparedStatement pr = null;
    private static ResultSet rs = null;

    public static List<Departamento> getAllDepartamentos() {
        List<Departamento> list_departamentos = new ArrayList<Departamento>();
        String sql_list = "select * from Departamento";

        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Departamento temp = new Departamento();
                temp.setId(rs.getInt(1));
                temp.setNombre(rs.getString(2));
                temp.setNum_dip(rs.getInt(3));
                
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

    public int getNum_dip() {
        return num_dip;
    }

    public void setNum_dip(int num_dip) {
        this.num_dip = num_dip;
    }
    
    
}
