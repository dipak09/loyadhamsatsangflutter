import 'dart:convert';
/// collection_id : "157233913-72157721334707394"
/// title : "Thakorji Maharaj"
/// sort : "1"
/// upload_file : "https://loyadham.in/uploads/dailydarshan_place/slider_d98744850cb59252f9a5dc3aa9941b5ethakorji.jpeg"

DarshanPlaceResModel darshanPlaceResModelFromJson(String str) => DarshanPlaceResModel.fromJson(json.decode(str));
String darshanPlaceResModelToJson(DarshanPlaceResModel data) => json.encode(data.toJson());
class DarshanPlaceResModel {
  DarshanPlaceResModel({
      String? collectionId, 
      String? title, 
      String? sort, 
      String? uploadFile,}){
    _collectionId = collectionId;
    _title = title;
    _sort = sort;
    _uploadFile = uploadFile;
}

  DarshanPlaceResModel.fromJson(dynamic json) {
    _collectionId = json['collection_id'];
    _title = json['title'];
    _sort = json['sort'];
    _uploadFile = json['upload_file'];
  }
  String? _collectionId;
  String? _title;
  String? _sort;
  String? _uploadFile;
DarshanPlaceResModel copyWith({  String? collectionId,
  String? title,
  String? sort,
  String? uploadFile,
}) => DarshanPlaceResModel(  collectionId: collectionId ?? _collectionId,
  title: title ?? _title,
  sort: sort ?? _sort,
  uploadFile: uploadFile ?? _uploadFile,
);
  String? get collectionId => _collectionId;
  String? get title => _title;
  String? get sort => _sort;
  String? get uploadFile => _uploadFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['collection_id'] = _collectionId;
    map['title'] = _title;
    map['sort'] = _sort;
    map['upload_file'] = _uploadFile;
    return map;
  }

}