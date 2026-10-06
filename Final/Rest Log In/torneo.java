package ejemplospringpintores.demo;
import java.sql.*;  


public class torneo {
    
    int torneo_id;
    String nombre;
    String lugar;
    Date fecha_inicio;
    Date fecha_fin;
    String descripcion;
    int precio;
    int premio;
    int equipos_permitidos;
    int max_jugadores_permitidos;
    int min_jugadores_permitidos;
    boolean privado;
    byte[] logo;
    int categoria;
    int creador;

    public torneo(int torneo_id, String nombre, String lugar, Date fecha_inicio, Date fecha_fin, String descripcion, int precio, int premio, int categoria) {
        this.torneo_id = torneo_id;
        this.nombre = nombre;
        this.lugar = lugar;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
        this.descripcion = descripcion;
        this.precio = precio;
        this.premio = premio;
          this.categoria = categoria;
    }
    public int getTorneoId(){
        return torneo_id;
    }
    public String getNombre(){
        return nombre;
    }
    public String getLugar(){
        return lugar;
    }
    public Date getFechaInicio(){
        return fecha_inicio;
    }
    public Date getFechaFin(){
        return fecha_fin;
    }
    public String getDescripcion(){
        return descripcion;
    }
    public int getPrecio(){
        return precio;
    }
    public int getPremio(){
        return premio;
    }
    public int getEquiposPermitidos(){
        return equipos_permitidos;
    }
    public int getMaxJugadoresPermitidos(){
        return max_jugadores_permitidos;
    }
    public int getMinJugadoresPermitidos(){
        return min_jugadores_permitidos;
    }
    public boolean getPrivado(){
        return privado;
    }
    public byte[] getLogo(){
        return logo;
    }
    public int getCategoria(){
        return categoria;
    }
    public int getCreador(){
        return creador;
    }

}
