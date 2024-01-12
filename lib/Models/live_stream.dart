class LiveStreamVideo {
  Channel1? channel1;

  LiveStreamVideo({this.channel1});

  LiveStreamVideo.fromJson(Map<String, dynamic> json) {
    channel1 = json['channel1'] != null
        ? new Channel1.fromJson(json['channel1'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channel1 != null) {
      data['channel1'] = this.channel1!.toJson();
    }
    return data;
  }
}

class Channel1 {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? initialId;

  Channel1({this.title, this.thumbnail, this.youtubeLink, this.initialId});

  Channel1.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    youtubeLink = json['youtube_link'];
    initialId = json['initial_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['youtube_link'] = this.youtubeLink;
    data['initial_id'] = this.initialId;
    return data;
  }
}
