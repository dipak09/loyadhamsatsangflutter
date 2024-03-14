class FeaturedMedia {
  List<FeaturedMediaDetail>? featuredMedia;

  FeaturedMedia({this.featuredMedia});

  FeaturedMedia.fromJson(Map<String, dynamic> json) {
    if (json['featured_media'] != null) {
      featuredMedia = <FeaturedMediaDetail>[];
      json['featured_media'].forEach((v) {
        featuredMedia!.add(new FeaturedMediaDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.featuredMedia != null) {
      data['featured_media'] =
          this.featuredMedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedMediaDetail {
  dynamic title;
  dynamic thumbnail;
  dynamic youtubeLink;
  dynamic initialId;
  dynamic publishedDate;
  dynamic timeAgo;
  dynamic viewCount;

  FeaturedMediaDetail(
      {this.title,
      this.thumbnail,
      this.youtubeLink,
      this.initialId,
      this.publishedDate,
      this.timeAgo,
      this.viewCount});

  FeaturedMediaDetail.fromJson(Map<String, dynamic> json) {
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
