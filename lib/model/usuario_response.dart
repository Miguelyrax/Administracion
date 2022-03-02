// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'package:administracion/model/usuario_model.dart';

UsuarioResponse usuarioResponseFromJson(String str) => UsuarioResponse.fromJson(json.decode(str));

String usuarioReponseToJson(UsuarioResponse data) => json.encode(data.toJson());

class UsuarioResponse {
    UsuarioResponse({
        this.usuarios,
    });

    List<Usuario> usuarios;

    factory UsuarioResponse.fromJson(Map<String, dynamic> json) => UsuarioResponse(
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}


