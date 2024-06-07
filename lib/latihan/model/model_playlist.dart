// To parse this JSON data, do
//
//     final modelPlaylist = modelPlaylistFromJson(jsonString);

import 'dart:convert';

ModelPlaylist modelPlaylistFromJson(String str) => ModelPlaylist.fromJson(json.decode(str));

String modelPlaylistToJson(ModelPlaylist data) => json.encode(data.toJson());

class ModelPlaylist {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelPlaylist({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPlaylist.fromJson(Map<String, dynamic> json) => ModelPlaylist(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judul;
  String penyanyi;
  String file;
  String gambar;

  Datum({
    required this.id,
    required this.judul,
    required this.penyanyi,
    required this.file,
    required this.gambar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    penyanyi: json["penyanyi"],
    file: json["file"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "penyanyi": penyanyi,
    "file": file,
    "gambar": gambar,
  };
}
