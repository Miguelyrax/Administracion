import 'dart:convert';
Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.status,
        this.google,
        this.id,
        this.nombre,
        this.email,
        this.password,
        this.role,
        this.online,
        this.v,
    });

    bool status;
    bool google;
    String id;
    String nombre;
    String email;
    String password;
    String role;
    String online;
    int v;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        status: json["status"],
        google: json["google"],
        id: json["_id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        online: json["online"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "google": google,
        "_id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
        "role": role,
        "online":online,
        "__v": v,
    };
}