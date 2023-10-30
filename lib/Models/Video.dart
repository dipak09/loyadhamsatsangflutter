class Video {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? initialId;

  Video({
    this.title,
    this.thumbnail,
    this.youtubeLink,
    this.initialId,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        thumbnail: json["thumbnail"],
        youtubeLink: json["youtube_link"],
        initialId: json["initial_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "youtube_link": youtubeLink,
        "initial_id": initialId,
      };
}
