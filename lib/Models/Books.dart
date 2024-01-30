class Books {
  String? id;
  String? language;
  String? bookName;
  String? description;
  String? uploadFile;
  String? uploadPdf;
  String? readUrl;

  Books(
      {this.id,
      this.language,
      this.bookName,
      this.description,
      this.uploadFile,
      this.uploadPdf,
      this.readUrl});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    bookName = json['book_name'];
    description = json['description'];
    uploadFile = json['Upload_file'];
    uploadPdf = json['upload_pdf'];
    readUrl = json['read_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['book_name'] = this.bookName;
    data['description'] = this.description;
    data['Upload_file'] = this.uploadFile;
    data['upload_pdf'] = this.uploadPdf;
    data['read_url'] = this.readUrl;
    return data;
  }
}
