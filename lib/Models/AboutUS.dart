class AboutUs {
  String? id;
  String? name;
  String? title;
  String? description;
  String? uploadFile;

  AboutUs({
    this.id,
    this.name,
    this.title,
    this.description,
    this.uploadFile,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        uploadFile: json["upload_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "description": description,
        "upload_file": uploadFile,
      };
}
