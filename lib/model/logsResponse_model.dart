// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'log_model.dart';

LogsResponse logsResponseFromJson(String str) => LogsResponse.fromJson(json.decode(str));

String logsResponseToJson(LogsResponse data) => json.encode(data.toJson());

class LogsResponse {
    LogsResponse({
        this.ok,
        this.logs,
    });

    bool ok;
    List<Log> logs;

    factory LogsResponse.fromJson(Map<String, dynamic> json) => LogsResponse(
        ok: json["ok"],
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
    };
}


