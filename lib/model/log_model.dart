import 'dart:convert';


Log logFromJson(String str) => Log.fromJson(json.decode(str));

String logToJson(Log data) => json.encode(data.toJson());

class Log {
    Log({
        this.id,
        this.log,
        this.usuario,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String log;
    UsuarioClass usuario;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["_id"],
        log: json["log"],
        usuario: UsuarioClass.fromJson(json["usuario"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "log": log,
        "usuario": usuario.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class UsuarioClass {
    UsuarioClass({
        this.id,
        this.nombre,
    });

    String id;
    String nombre;

    factory UsuarioClass.fromJson(Map<String, dynamic> json) => UsuarioClass(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
    };
}