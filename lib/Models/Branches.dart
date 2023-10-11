class Branches {
  String? id;
  String? name;
  String? mobileNumber;
  String? emailId;
  String? address;
  String? uploadFile;

  Branches({
    this.id,
    this.name,
    this.mobileNumber,
    this.emailId,
    this.address,
    this.uploadFile,
  });

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        emailId: json["email_id"],
        address: json["address"],
        uploadFile: json["upload_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_number": mobileNumber,
        "email_id": emailId,
        "address": address,
        "upload_file": uploadFile,
      };
}
