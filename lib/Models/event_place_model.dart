import 'dart:convert';
/// id : "21515"
/// sort : "8"
/// event_collection_id : "157233913-72157721745966317"
/// event_title : "Loyadham Canada"
/// year_id : "157233913-72157721745966757"
/// year_title : "2023"
/// album_id : "72177720310790613"
/// album_title : "6th Patotsav Canada Day 3 08-20-2023"
/// photo_id : "53146499649"
/// width : "6000"
/// height : "3368"
/// source : "https://live.staticflickr.com/65535/53146499649_091e968656_o.jpg"
/// text : "{\"label\":\"Original\",\"width\":6000,\"height\":3368,\"source\":\"https:\\/\\/live.staticflickr.com\\/65535\\/53146499649_091e968656_o.jpg\",\"url\":\"https:\\/\\/www.flickr.com\\/photos\\/157326726@N08\\/53146499649\\/sizes\\/o\\/\",\"media\":\"photo\"}"
/// created_at : "2023-08-20 12:00:00"
/// status : "Active"
/// album_date_new : "08-20-2023"
/// album_title_new : "6th Patotsav Canada Day 3"

EventPlaceModel eventPlaceModelFromJson(String str) => EventPlaceModel.fromJson(json.decode(str));
String eventPlaceModelToJson(EventPlaceModel data) => json.encode(data.toJson());
class EventPlaceModel {
  EventPlaceModel({
      String? id, 
      String? sort, 
      String? eventCollectionId, 
      String? eventTitle, 
      String? yearId, 
      String? yearTitle, 
      String? albumId, 
      String? albumTitle, 
      String? photoId, 
      String? width, 
      String? height, 
      String? source, 
      String? text, 
      String? createdAt, 
      String? status, 
      String? albumDateNew, 
      String? albumTitleNew,}){
    _id = id;
    _sort = sort;
    _eventCollectionId = eventCollectionId;
    _eventTitle = eventTitle;
    _yearId = yearId;
    _yearTitle = yearTitle;
    _albumId = albumId;
    _albumTitle = albumTitle;
    _photoId = photoId;
    _width = width;
    _height = height;
    _source = source;
    _text = text;
    _createdAt = createdAt;
    _status = status;
    _albumDateNew = albumDateNew;
    _albumTitleNew = albumTitleNew;
}

  EventPlaceModel.fromJson(dynamic json) {
    _id = json['id'];
    _sort = json['sort'];
    _eventCollectionId = json['event_collection_id'];
    _eventTitle = json['event_title'];
    _yearId = json['year_id'];
    _yearTitle = json['year_title'];
    _albumId = json['album_id'];
    _albumTitle = json['album_title'];
    _photoId = json['photo_id'];
    _width = json['width'];
    _height = json['height'];
    _source = json['source'];
    _text = json['text'];
    _createdAt = json['created_at'];
    _status = json['status'];
    _albumDateNew = json['album_date_new'];
    _albumTitleNew = json['album_title_new'];
  }
  String? _id;
  String? _sort;
  String? _eventCollectionId;
  String? _eventTitle;
  String? _yearId;
  String? _yearTitle;
  String? _albumId;
  String? _albumTitle;
  String? _photoId;
  String? _width;
  String? _height;
  String? _source;
  String? _text;
  String? _createdAt;
  String? _status;
  String? _albumDateNew;
  String? _albumTitleNew;
EventPlaceModel copyWith({  String? id,
  String? sort,
  String? eventCollectionId,
  String? eventTitle,
  String? yearId,
  String? yearTitle,
  String? albumId,
  String? albumTitle,
  String? photoId,
  String? width,
  String? height,
  String? source,
  String? text,
  String? createdAt,
  String? status,
  String? albumDateNew,
  String? albumTitleNew,
}) => EventPlaceModel(  id: id ?? _id,
  sort: sort ?? _sort,
  eventCollectionId: eventCollectionId ?? _eventCollectionId,
  eventTitle: eventTitle ?? _eventTitle,
  yearId: yearId ?? _yearId,
  yearTitle: yearTitle ?? _yearTitle,
  albumId: albumId ?? _albumId,
  albumTitle: albumTitle ?? _albumTitle,
  photoId: photoId ?? _photoId,
  width: width ?? _width,
  height: height ?? _height,
  source: source ?? _source,
  text: text ?? _text,
  createdAt: createdAt ?? _createdAt,
  status: status ?? _status,
  albumDateNew: albumDateNew ?? _albumDateNew,
  albumTitleNew: albumTitleNew ?? _albumTitleNew,
);
  String? get id => _id;
  String? get sort => _sort;
  String? get eventCollectionId => _eventCollectionId;
  String? get eventTitle => _eventTitle;
  String? get yearId => _yearId;
  String? get yearTitle => _yearTitle;
  String? get albumId => _albumId;
  String? get albumTitle => _albumTitle;
  String? get photoId => _photoId;
  String? get width => _width;
  String? get height => _height;
  String? get source => _source;
  String? get text => _text;
  String? get createdAt => _createdAt;
  String? get status => _status;
  String? get albumDateNew => _albumDateNew;
  String? get albumTitleNew => _albumTitleNew;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sort'] = _sort;
    map['event_collection_id'] = _eventCollectionId;
    map['event_title'] = _eventTitle;
    map['year_id'] = _yearId;
    map['year_title'] = _yearTitle;
    map['album_id'] = _albumId;
    map['album_title'] = _albumTitle;
    map['photo_id'] = _photoId;
    map['width'] = _width;
    map['height'] = _height;
    map['source'] = _source;
    map['text'] = _text;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    map['album_date_new'] = _albumDateNew;
    map['album_title_new'] = _albumTitleNew;
    return map;
  }

}