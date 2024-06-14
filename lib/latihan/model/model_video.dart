import 'dart:convert';

class ModelVideo {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelVideo({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelVideo.fromJson(Map<String, dynamic> json) => ModelVideo(
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
  String video;

  Datum({
    required this.id,
    required this.judul,
    required this.video,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "video": video,
  };
}
