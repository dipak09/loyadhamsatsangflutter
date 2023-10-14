class Books {
  String? id;
  String? language;
  String? bookName;
  String? description;
  String? uploadFile;
  String? uploadPdf;

  Books({
    this.id,
    this.language,
    this.bookName,
    this.description,
    this.uploadFile,
    this.uploadPdf,
  });

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        id: json["id"],
        language: json["language"],
        bookName: json["book_name"],
        description: json["description"],
        uploadFile: json["Upload_file"],
        uploadPdf: json["upload_pdf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "book_name": bookName,
        "description": description,
        "Upload_file": uploadFile,
        "upload_pdf": uploadPdf,
      };
}
