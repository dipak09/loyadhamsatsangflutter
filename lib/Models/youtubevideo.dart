class YoutubeVideo {
  List<ListYoutubeVideo>? youtubeVideo;
  String? pageToken;

  YoutubeVideo({this.youtubeVideo, this.pageToken});

  YoutubeVideo.fromJson(Map<String, dynamic> json) {
    if (json['youtube_video'] != null) {
      youtubeVideo = <ListYoutubeVideo>[];
      json['youtube_video'].forEach((v) {
        youtubeVideo!.add(new ListYoutubeVideo.fromJson(v));
      });
    }
    pageToken = json['pageToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.youtubeVideo != null) {
      data['youtube_video'] =
          this.youtubeVideo!.map((v) => v.toJson()).toList();
    }
    data['pageToken'] = this.pageToken;
    return data;
  }
}

class ListYoutubeVideo {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? initialId;
  String? publishedDate;
  String? timeAgo;
  String? viewCount;

  ListYoutubeVideo(
      {this.title,
      this.thumbnail,
      this.youtubeLink,
      this.initialId,
      this.publishedDate,
      this.timeAgo,
      this.viewCount});

  ListYoutubeVideo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    youtubeLink = json['youtube_link'];
    initialId = json['initial_id'];
    publishedDate = json['published_date'];
    timeAgo = json['time_ago'];
    viewCount = json['view_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['youtube_link'] = this.youtubeLink;
    data['initial_id'] = this.initialId;
    data['published_date'] = this.publishedDate;
    data['time_ago'] = this.timeAgo;
    data['view_count'] = this.viewCount;
    return data;
  }
}

