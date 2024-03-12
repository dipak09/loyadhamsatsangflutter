class OurApplicationModel {
  String? sort;
  String? appName;
  String? description;
  String? androidLink;
  String? iosLink;
  List<String>? coverImage;

  OurApplicationModel(
      {this.sort,
      this.appName,
      this.description,
      this.androidLink,
      this.iosLink,
      this.coverImage});

  OurApplicationModel.fromJson(Map<String, dynamic> json) {
    sort = json['sort'];
    appName = json['app_name'];
    description = json['description'];
    androidLink = json['android_link'];
    iosLink = json['ios_link'];
    coverImage = json['cover_image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sort'] = this.sort;
    data['app_name'] = this.appName;
    data['description'] = this.description;
    data['android_link'] = this.androidLink;
    data['ios_link'] = this.iosLink;
    data['cover_image'] = this.coverImage;
    return data;
  }
}