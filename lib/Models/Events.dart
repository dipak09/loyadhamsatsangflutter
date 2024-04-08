class Events {
  String? id;
  String? eventCollectionId;
  String? eventTitle;
  String? yearId;
  String? yearTitle;
  String? albumId;
  String? albumTitle;
  String? photoId;
  String? width;
  String? height;
  String? source;
  String? text;
  DateTime? createdAt;
  String? status;
  String? date;
  String? album_date_new;
  String? album_title_new;

  Events({
    this.id,
    this.eventCollectionId,
    this.eventTitle,
    this.yearId,
    this.yearTitle,
    this.albumId,
    this.albumTitle,
    this.photoId,
    this.width,
    this.height,
    this.source,
    this.text,
    this.createdAt,
    this.status,
    this.date,
    this.album_date_new,
    this.album_title_new,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        id: json["id"],
        eventCollectionId: json["event_collection_id"],
        eventTitle: json["event_title"],
        yearId: json["year_id"],
        yearTitle: json["year_title"],
        albumId: json["album_id"],
        albumTitle: json["album_title"],
        photoId: json["photo_id"],
        width: json["width"],
        height: json["height"],
        source: json["source"],
        text: json["text"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"],
        date: json["date"],
    album_date_new: json["album_date_new"],
    album_title_new: json["album_title_new"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_collection_id": eventCollectionId,
        "event_title": eventTitle,
        "year_id": yearId,
        "year_title": yearTitle,
        "album_id": albumId,
        "album_title": albumTitle,
        "photo_id": photoId,
        "width": width,
        "height": height,
        "source": source,
        "text": text,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "date": date,
    "album_date_new":album_date_new,
    "album_title_new":album_title_new
      };
}
