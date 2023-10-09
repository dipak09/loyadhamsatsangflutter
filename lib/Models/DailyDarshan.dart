class DailyDarshan {
  String id;
  String dailyDarshanMasterId;
  String collectionId;
  String title;
  String albumId;
  String albumTitle;
  DateTime createdAt;
  String source;

  DailyDarshan({
    required this.id,
    required this.dailyDarshanMasterId,
    required this.collectionId,
    required this.title,
    required this.albumId,
    required this.albumTitle,
    required this.createdAt,
    required this.source,
  });

  factory DailyDarshan.fromJson(Map<String, dynamic> json) => DailyDarshan(
        id: json["id"],
        dailyDarshanMasterId: json["daily_darshan_master_id"],
        collectionId: json["collection_id"],
        title: json["title"],
        albumId: json["album_id"],
        albumTitle: json["album_title"],
        createdAt: DateTime.parse(json["created_at"]),
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "daily_darshan_master_id": dailyDarshanMasterId,
        "collection_id": collectionId,
        "title": title,
        "album_id": albumId,
        "album_title": albumTitle,
        "created_at": createdAt.toIso8601String(),
        "source": source,
      };
}
