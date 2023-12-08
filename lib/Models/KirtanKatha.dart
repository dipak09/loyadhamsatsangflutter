class KirtanKatha {
  String? id;
  String? singerId;
  String? type;
  String? eventName;
  String? uploadFile;
  String? kathaMasterId;
  String? album_total_duration;

  KirtanKatha({
    this.id,
    this.singerId,
    this.type,
    this.eventName,
    this.uploadFile,
    this.kathaMasterId,
    this.album_total_duration
  });

  factory KirtanKatha.fromJson(Map<String, dynamic> json) => KirtanKatha(
        id: json["id"],
        singerId: json["singer_id"],
        type: json["type"],
        eventName: json["event_name"],
        uploadFile: json["upload_file"],
        kathaMasterId: json["katha_master_id"],
        album_total_duration: json["album_total_duration"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "singer_id": singerId,
        "type": type,
        "event_name": eventName,
        "upload_file": uploadFile,
        "katha_master_id": kathaMasterId,
        "album_total_duration": album_total_duration
      };
}
