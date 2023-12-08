class KirtanKathaAudio {
  String? singerId;
  String? singerName;
  String? singerStatus;
  String? id;
  String? sort;
  String? kathaMasterId;
  String? kirtanKathaAudioSingerId;
  String? fileName;
  String? audio_duration;
  String? uploadAudio;

  KirtanKathaAudio({
    this.singerId,
    this.singerName,
    this.singerStatus,
    this.id,
    this.sort,
    this.kathaMasterId,
    this.kirtanKathaAudioSingerId,
    this.fileName,
    this.uploadAudio,
    this.audio_duration,
  });

  factory KirtanKathaAudio.fromJson(Map<String, dynamic> json) =>
      KirtanKathaAudio(
        singerId: json["singerId"],
        singerName: json["singerName"],
        singerStatus: json["singerStatus"],
        id: json["id"],
        sort: json["sort"],
        kathaMasterId: json["katha_master_id"],
        kirtanKathaAudioSingerId: json["singer_id"],
        fileName: json["file_name"],
        uploadAudio: json["upload_audio"],
        audio_duration: json["audio_duration"],
      );

  Map<String, dynamic> toJson() => {
        "singerId": singerId,
        "singerName": singerName,
        "singerStatus": singerStatus,
        "id": id,
        "sort": sort,
        "katha_master_id": kathaMasterId,
        "singer_id": kirtanKathaAudioSingerId,
        "file_name": fileName,
        "upload_audio": uploadAudio,
        "audio_duration": audio_duration
      };
}
