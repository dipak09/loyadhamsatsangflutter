class Prashadi {
  String? id;
  String? type;
  String? shortTitle;
  String? title;
  String? description;
  String? uploadFile;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  Prashadi({
    this.id,
    this.type,
    this.shortTitle,
    this.title,
    this.description,
    this.uploadFile,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Prashadi.fromJson(Map<String, dynamic> json) => Prashadi(
        id: json["id"],
        type: json["type"],
        shortTitle: json["short_title"],
        title: json["title"],
        description: json["description"],
        uploadFile: json["upload_file"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "short_title": shortTitle,
        "title": title,
        "description": description,
        "upload_file": uploadFile,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
      };
}
