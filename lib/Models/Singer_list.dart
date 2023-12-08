class SingerList {
  String? id;
  String? type;
  String? name;
  String? seoUrl;

  SingerList({this.id, this.type, this.name, this.seoUrl});

  SingerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    seoUrl = json['seo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['seo_url'] = this.seoUrl;
    return data;
  }
}
