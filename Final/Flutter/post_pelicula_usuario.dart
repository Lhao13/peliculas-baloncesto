
import 'dart:convert';

PostPeliculaUsuario postPeliculaUsuarioFromJson(String str) => PostPeliculaUsuario.fromJson(json.decode(str));

String postPeliculaUsuarioToJson(PostPeliculaUsuario data) => json.encode(data.toJson());

class PostPeliculaUsuario {
    int peliculaId;
    String? comentario;
    int? calificacion;
    bool estado;
    String? fechaVista;

    PostPeliculaUsuario({
        required this.peliculaId,
        this.comentario,
        this.calificacion,
        required this.estado,
        this.fechaVista,
    });

    factory PostPeliculaUsuario.fromJson(Map<String, dynamic> json) => PostPeliculaUsuario(
        peliculaId: json["pelicula_id"],
        calificacion: json["calificacion"],
        estado: json["estado"],
        fechaVista: json["fecha_vista"],
    );

    Map<String, dynamic> toJson() => {
        "pelicula_id": peliculaId,
        "comentario": comentario,
        "calificacion": calificacion,
        "estado": estado,
        "fecha_vista": fechaVista == ''
          ? null
          : fechaVista,
    };
}