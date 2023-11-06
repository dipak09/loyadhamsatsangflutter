class Video {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? initialId;
  DateTime? publishedDate;
  String? timeAgo;
  String? viewCount;

  Video({
    this.title,
    this.thumbnail,
    this.youtubeLink,
    this.initialId,
    this.publishedDate,
    this.timeAgo,
    this.viewCount,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        thumbnail: json["thumbnail"],
        youtubeLink: json["youtube_link"],
        initialId: json["initial_id"],
        publishedDate: json["published_date"] == null
            ? null
            : DateTime.parse(json["published_date"]),
        timeAgo: json["time_ago"],
        viewCount: json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "youtube_link": youtubeLink,
        "initial_id": initialId,
        "published_date":
            "${publishedDate!.year.toString().padLeft(4, '0')}-${publishedDate!.month.toString().padLeft(2, '0')}-${publishedDate!.day.toString().padLeft(2, '0')}",
        "time_ago": timeAgo,
        "view_count": viewCount,
      };
}
