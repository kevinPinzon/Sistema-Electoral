/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author alex
 */
public class arraydiputados_partido {
    private String partido_name;
    private int partido_id;
    private List<Candidato_pp> diputados = new ArrayList<Candidato_pp>();

    public String getPartido() {
        return partido_name;
    }

    public void setPartido(String partido) {
        this.partido_name = partido;
    }
    
    public int getPartido_id() {
        return partido_id;
    }

    public void setPartido_id(int partido) {
        this.partido_id = partido;
    }

    public void addDiputado(Candidato_pp diputado){
        diputados.add(diputado);
    }
    
    public Candidato_pp getDiputado(int index){
        return diputados.get(index);
    }
    
    public int getSize(){
        return diputados.size();
    }
    
    public List<Candidato_pp> getDiputados(){
        return diputados;
    }
    
}
