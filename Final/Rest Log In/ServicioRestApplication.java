package ejemplospringpintores.demo;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ServicioRestApplication {

    @GetMapping(value="/logIn", produces = "application/json")
    private static List<persona> logIn(@RequestParam String correo, @RequestParam String contrasena) {
        List<persona> persona = new ArrayList<>();
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT primer_nombre, primer_apellido, persona_id, preferencia FROM persona WHERE correo = ? AND contrasena = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, correo);
                statement.setString(2, contrasena);
                try (ResultSet resultSet = statement.executeQuery()) {
                  if(resultSet.next()){
                    String primer_nombre = resultSet.getString("primer_nombre");
                    String primer_apellido = resultSet.getString("primer_apellido");
                    int id = resultSet.getInt("persona_id");
                    int preferencia = resultSet.getInt("preferencia");
                    persona.add(new persona(primer_nombre, primer_apellido,id, preferencia));
                  }  
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return persona;
    }
  
    

    @GetMapping(value="/signUp", produces = "application/json")
    private static List<persona> signUp(String primer_nombre, String primer_apellido, String birthday, boolean genero, int preferencia, String correo, String contrasena) {
        List<persona> persona = new ArrayList<>();
        if (checkCorreo(correo)==false) {
            if(primer_nombre.length() <= 50){
                if(primer_apellido.length() <= 50){
                    if(Date.valueOf("1900-01-01").before(Date.valueOf(birthday)) || Date.valueOf("2024-04-06").after(Date.valueOf(birthday))){
                        if(correo.contains("@")){

            
        
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "INSERT INTO persona(primer_nombre, primer_apellido, birthday, genero, preferencia, correo, contrasena) VALUES(?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, primer_nombre);
                statement.setString(2, primer_apellido);
                statement.setString(3, birthday);
                statement.setBoolean(4, genero);
                statement.setInt(5, preferencia);
                statement.setString(6, correo);
                statement.setString(7, contrasena);
                try {
                    statement.executeUpdate();                  
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logIn(correo, contrasena);
    }
    else{
        persona.add(new persona("01", null,0,0));//@
        return persona;
    }    
    }
    else{
        persona.add(new persona("02", null,0,0));//fecha
        return persona;
    }
    }
    else{
        persona.add(new persona("03", null,0,0));//apellido
        return persona;
    }
    
    }
    else{
        persona.add(new persona("04", null,0,0)); //nombre
        return persona;
    }  
        
    }
   
    else{
        persona.add(new persona(null, null,0,0));
        return persona;
    }
    }

    @GetMapping(value="/checkCorreo", produces = "application/json")
    public boolean getCheckCorreo(@RequestParam String correo) {
        return checkCorreo(correo);
    }
    private static boolean checkCorreo(String correo) {
        boolean mail = false;
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT correo FROM persona WHERE correo = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, correo);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        mail=true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mail;
    }

    @GetMapping(value="/home", produces = "application/json")
    public List<torneo> getHome() {
        return home();
    }
    private static List<torneo> home(){
        List<torneo> torneo = new ArrayList<>();
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT torneo_id, nombre, lugar, fecha_inicio, fecha_fin, descripcion, precio, premio, categoria FROM torneo";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int torneo_id = resultSet.getInt("torneo_id");
                        String nombre = resultSet.getString("nombre");
                        String lugar = resultSet.getString("lugar");
                        Date fecha_inicio = resultSet.getDate("fecha_inicio");
                        Date fecha_fin = resultSet.getDate("fecha_fin");
                        String descripcion = resultSet.getString("descripcion");
                        int precio = resultSet.getInt("precio");
                        int premio = resultSet.getInt("premio");
                        int categoria = resultSet.getInt("categoria");
                        torneo.add(new torneo(torneo_id, nombre, lugar, fecha_inicio, fecha_fin, descripcion, precio, premio, categoria));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
    }
        return torneo;
}


    
}