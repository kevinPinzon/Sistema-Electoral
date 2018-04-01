/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author alex
 */
public class Mesa_Electoral {

    private int id;
    private String lugar_descripcion;
    private String lugar_nombre;
    private int estado;
    private Date apertura;
    private Date cierre;
    private int id_municipio;
    private int id_resultado;

    private String estado_cadena;
    private String municipio_cadena, departamento_cadena;

    private static String classfor = "oracle.jdbc.driver.OracleDriver";
    private static String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String usuario = "SISTEMA_ELECTORAL";
    private static String pass = "1234";

    private static Connection con = null;

    public static String insertar(int id, String lugar_nombre, String lugar_descripcion, int id_municipio) {
        String sql = "insert into MESA_ELECTORAL values(?,?,?,?,?,?,?,?)";
        int result = 0;
        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);

            PreparedStatement pr = con.prepareStatement(sql);
            pr = con.prepareStatement(sql);
            pr.setInt(1, id);//id
            pr.setInt(2, 1);//estado
            pr.setDate(3, new Date(0, 0, 0));//apertura
            pr.setDate(4, new Date(0, 0, 0));//cierre
            pr.setInt(5, 0);//id_result
            pr.setString(6, lugar_nombre);
            pr.setString(7, lugar_descripcion);
            pr.setInt(8, id_municipio);//id_municipio

            result = pr.executeUpdate();
            con.close();
        } catch (Exception e) {
            return e.getMessage();
        }
        return "insert";
    }

    public static List<Mesa_Electoral> getAllMEs(List<Municipio> list_muni) {
        List<Mesa_Electoral> list_me = new ArrayList<Mesa_Electoral>();
        String sql_list = "select * from MESA_ELECTORAL ORDER BY ID_MUNICIPIO ASC";

        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mesa_Electoral temp = new Mesa_Electoral();
                temp.setId(rs.getInt(1));
                temp.setEstado(rs.getInt(2));
                temp.setLugar_nombre(rs.getString(6));
                temp.setLugar_descripcion(rs.getString(7));
                temp.setId_municipio(rs.getInt(8));

                String dep_cadena = "-", muni_cadnea = "-";
                for (Municipio municipio_current : list_muni) {
                    if (municipio_current.getId() == rs.getInt(8)) {
                        muni_cadnea = municipio_current.getNombre();
                        switch (municipio_current.getId_dep()) {
                            case 1:
                                dep_cadena = "Atlantida";
                                break;
                            case 2:
                                dep_cadena = "Colon";
                                break;
                            case 3:
                                dep_cadena = "Comayagua";
                                break;
                            case 4:
                                dep_cadena = "Copan";
                                break;
                            case 5:
                                dep_cadena = "Cortes";
                                break;
                            case 6:
                                dep_cadena = "Choluteca";
                                break;
                            case 7:
                                dep_cadena = "El Paraiso";
                                break;
                            case 8:
                                dep_cadena = "Francisco Morazan";
                                break;
                            case 9:
                                dep_cadena = "Gracias a Dios";
                                break;
                            case 10:
                                dep_cadena = "Intibuca";
                                break;
                            case 11:
                                dep_cadena = "Roatan";
                                break;
                            case 12:
                                dep_cadena = "La Paz";
                                break;
                            case 13:
                                dep_cadena = "Lempira";
                                break;
                            case 14:
                                dep_cadena = "Ocotepeque";
                                break;
                            case 15:
                                dep_cadena = "Olancho";
                                break;
                            case 16:
                                dep_cadena = "Santa Barbara";
                                break;
                            case 17:
                                dep_cadena = "Valle";
                                break;
                            case 18:
                                dep_cadena = "Yoro";
                                break;
                            default:
                                dep_cadena = "-";
                                break;
                        }
                    }
                }
                temp.setDepartamento_cadena(dep_cadena);
                temp.setMunicipio_cadena(muni_cadnea);

                if (rs.getInt(2) == 3) {
                    temp.setEstado_cadena("Cerrada");
                } else if (rs.getInt(2) == 2) {
                    temp.setEstado_cadena("Aperturada");
                } else {
                    temp.setEstado_cadena("Desabilitada");
                }
                list_me.add(temp);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list_me;
    }

    public static Mesa_Electoral getMesa_Electoral(int id_mesa, List<Municipio> list_muni){
        Mesa_Electoral mesa_electoral = new Mesa_Electoral();
        String sql_list = "select * from MESA_ELECTORAL where ID=?";
        
        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, id_mesa);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mesa_electoral.setId(rs.getInt(1));
                mesa_electoral.setEstado(rs.getInt(2));
                mesa_electoral.setLugar_nombre(rs.getString(6));
                mesa_electoral.setLugar_descripcion(rs.getString(7));
                mesa_electoral.setId_municipio(rs.getInt(8));

                String dep_cadena = "-", muni_cadnea = "-";
                for (Municipio municipio_current : list_muni) {
                    if (municipio_current.getId() == rs.getInt(8)) {
                        muni_cadnea = municipio_current.getNombre();
                        switch (municipio_current.getId_dep()) {
                            case 1:
                                dep_cadena = "Atlantida";
                                break;
                            case 2:
                                dep_cadena = "Colon";
                                break;
                            case 3:
                                dep_cadena = "Comayagua";
                                break;
                            case 4:
                                dep_cadena = "Copan";
                                break;
                            case 5:
                                dep_cadena = "Cortes";
                                break;
                            case 6:
                                dep_cadena = "Choluteca";
                                break;
                            case 7:
                                dep_cadena = "El Paraiso";
                                break;
                            case 8:
                                dep_cadena = "Francisco Morazan";
                                break;
                            case 9:
                                dep_cadena = "Gracias a Dios";
                                break;
                            case 10:
                                dep_cadena = "Intibuca";
                                break;
                            case 11:
                                dep_cadena = "Roatan";
                                break;
                            case 12:
                                dep_cadena = "La Paz";
                                break;
                            case 13:
                                dep_cadena = "Lempira";
                                break;
                            case 14:
                                dep_cadena = "Ocotepeque";
                                break;
                            case 15:
                                dep_cadena = "Olancho";
                                break;
                            case 16:
                                dep_cadena = "Santa Barbara";
                                break;
                            case 17:
                                dep_cadena = "Valle";
                                break;
                            case 18:
                                dep_cadena = "Yoro";
                                break;
                            default:
                                dep_cadena = "-";
                                break;
                        }
                    }
                }
                mesa_electoral.setDepartamento_cadena(dep_cadena);
                mesa_electoral.setMunicipio_cadena(muni_cadnea);

                if (rs.getInt(2) == 3) {
                    mesa_electoral.setEstado_cadena("Cerrada");
                } else if (rs.getInt(2) == 2) {
                    mesa_electoral.setEstado_cadena("Aperturada");
                } else {
                    mesa_electoral.setEstado_cadena("Desabilitada");
                }
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mesa_electoral;
    }
    
    public static int update_estado(int id_mesa, int estado) {
        int status = 0;
        String sql_list = "update MESA_ELECTORAL set ESTADO=? where ID=?";

        try {
            Class.forName(classfor);
            con = DriverManager.getConnection(url, usuario, pass);
            PreparedStatement ps = con.prepareStatement(sql_list);
            ps.setInt(1, estado);
            ps.setInt(2, id_mesa);

            status = ps.executeUpdate();
            con.close();
        } catch (Exception e) {
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

    public String getLugar_descripcion() {
        return lugar_descripcion;
    }

    public void setLugar_descripcion(String lugar_descripcion) {
        this.lugar_descripcion = lugar_descripcion;
    }

    public String getLugar_nombre() {
        return lugar_nombre;
    }

    public void setLugar_nombre(String lugar_nombre) {
        this.lugar_nombre = lugar_nombre;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getApertura() {
        return apertura;
    }

    public void setApertura(Date apertura) {
        this.apertura = apertura;
    }

    public Date getCierre() {
        return cierre;
    }

    public void setCierre(Date cierre) {
        this.cierre = cierre;
    }

    public int getId_municipio() {
        return id_municipio;
    }

    public void setId_municipio(int id_municipio) {
        this.id_municipio = id_municipio;
    }

    public int getId_resultado() {
        return id_resultado;
    }

    public void setId_resultado(int id_resultado) {
        this.id_resultado = id_resultado;
    }

    public String getEstado_cadena() {
        return estado_cadena;
    }

    public void setEstado_cadena(String estado_cadena) {
        this.estado_cadena = estado_cadena;
    }

    public String getMunicipio_cadena() {
        return municipio_cadena;
    }

    public void setMunicipio_cadena(String municipio_cadena) {
        this.municipio_cadena = municipio_cadena;
    }

    public String getDepartamento_cadena() {
        return departamento_cadena;
    }

    public void setDepartamento_cadena(String departamento_cadena) {
        this.departamento_cadena = departamento_cadena;
    }

}
