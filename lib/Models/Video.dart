class Video {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? initialId;
  String? publishedDate;
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
        publishedDate: json["published_date"],
        timeAgo: json["time_ago"],
        viewCount: json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "youtube_link": youtubeLink,
        "initial_id": initialId,
        "published_date": publishedDate,
        "time_ago": timeAgo,
        "view_count": viewCount,
      };
}
