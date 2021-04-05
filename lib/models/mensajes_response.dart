// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) => MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) => json.encode(data.toJson());

class MensajesResponse {
    MensajesResponse({
        this.ok,
        this.mensajes,
    });

    bool ok;
    List<Mensaje> mensajes;

    factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
    };
}

class Mensaje {
    Mensaje({
        this.emisor,
        this.receptor,
        this.mensaje,
        this.createdAt,
        this.updatedAt,
    });

    String emisor;
    String receptor;
    String mensaje;
    DateTime createdAt;
    DateTime updatedAt;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        emisor: json["emisor"],
        receptor: json["receptor"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "emisor": emisor,
        "receptor": receptor,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
