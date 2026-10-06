package ejemplospringpintores.demo;
import java.sql.*;  


class persona{
    private int persona_id;
    private String primer_nombre;
    private String segundo_nombre;
    private String primer_apellido;
    private String segundo_apellido;
    private String birth_country;
    private String birth_province;
    private String birth_city;
    private Date birthday;
    private boolean genero;
    private int estatura;
    private int peso;
    private String telefono;
    private String correo;
    private String posicion_principal;
    private String posicion_secundaria;
    private boolean arbitro;
    private byte[] profile_pic;
    private String contrasena;
    private int preferencia;

    public persona(String nombre, String apellido, int id, int preferencia) {
        this.primer_nombre = nombre;
        this.primer_apellido = apellido;  
        this.persona_id = id;    
        this.preferencia = preferencia;
    }
    
    public void setPrimerNombre(String primer_nombre){
            this.primer_nombre = primer_nombre;
    }  

    public void setPrimerApellido(String primer_apellido){
            this.primer_apellido = primer_apellido;
    }

    public void setBirthday(Date birthday){
            this.birthday = birthday;
    }

    public void setGenero(boolean genero){
        this.genero = genero;
    }

    


    public void setCorreo(String correo){
            this.correo = correo;  
    }

    public void setContrasena(String contrasena){
            this.contrasena = contrasena;
    }

    public void setSegundoNombre(String segundo_nombre){
        if (segundo_nombre.length() <= 50){
            this.segundo_nombre = segundo_nombre;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setSegundoApellido(String segundo_apellido){
        if (segundo_apellido.length() <= 50){
            this.segundo_apellido = segundo_apellido;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setBirthCountry(String birth_country){
        if (birth_country.length() <= 50){
            this.birth_country = birth_country;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setBirthProvince(String birth_province){
        if (birth_province.length() <= 50){
            this.birth_province = birth_province;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setBirthCity(String birth_city){
        if (birth_city.length() <= 50){
            this.birth_city = birth_city;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setEstatura(int estatura){
        if(estatura <=272 && estatura >= 50){
        this.estatura = estatura;
        }
        else{
            System.out.println("La estatura maxima es de 272 cm y minimo de 50 cm");
        }
    }

    public void setPeso(int peso){
        if(peso <= 655 && peso >= 2){
        this.peso = peso;
        }
        else{
            System.out.println("El peso maximo es de 655 kg y minimo de 2 kg");
        }
    }

    public void setTelefono(String telefono){
        if(telefono.length() <= 10){
        this.telefono = telefono;
        }
        else{
            System.out.println("El numero de telefono no puede tener mas de 10 digitos, solo se aceptan numeros");
        }
    }

    public void setPosicionPrincipal(String posicion_principal){
        if (posicion_principal.length() <= 50){
            this.posicion_principal = posicion_principal;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setPosicionSecundaria(String posicion_secundaria){
        if (posicion_secundaria.length() <= 50){
            this.posicion_secundaria = posicion_secundaria;
        }
        else{
            System.out.println("La cantidad maxima de caracteres es 50");
        }
    }

    public void setArbitro(boolean arbitro){
        this.arbitro = arbitro;
    }

    public void setProfilePic(byte[] profile_pic){
        this.profile_pic = profile_pic;
    }

    public int getPersonaId(){
        return persona_id;
    }

    public String getPrimerNombre(){
        return primer_nombre;
    }

    public String getSegundoNombre(){
        return segundo_nombre;
    }

    public String getPrimerApellido(){
        return primer_apellido;
    }

    public String getSegundoApellido(){
        return segundo_apellido;
    }

    public String getBirthCountry(){
        return birth_country;
    }

    public String getBirthProvince(){
        return birth_province;
    }

    public String getBirthCity(){
        return birth_city;
    }

    public Date getBirthday(){
        return birthday;
    }

    public boolean getGenero(){
        return genero;
    }

    public int getEstatura(){
        return estatura;
    }

    public int getPeso(){
        return peso;
    }

    public String getTelefono(){
        return telefono;
    }

    public String getCorreo(){
        return correo;
    }

    public String getPosicionPrincipal(){
        return posicion_principal;
    }

    public String getPosicionSecundaria(){
        return posicion_secundaria;
    }

    public boolean getArbitro(){
        return arbitro;
    }   

    public byte[] getProfilePic(){
        return profile_pic;
    }

    public String getContrasena(){
        return contrasena;
    } 

    public int getPreferencia(){
        return preferencia;
    }

}