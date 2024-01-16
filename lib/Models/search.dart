class Search {
  List<Book>? book;
  List<YoutubeUs>? youtubeUs;
  List<YoutubeIn>? youtubeIn;
  List<KathaAudio>? kathaAudio;

  Search({this.book, this.youtubeUs, this.youtubeIn, this.kathaAudio});

  Search.fromJson(Map<String, dynamic> json) {
    if (json['book'] != null) {
      book = <Book>[];
      json['book'].forEach((v) {
        book!.add(new Book.fromJson(v));
      });
    }
    if (json['youtube_us'] != null) {
      youtubeUs = <YoutubeUs>[];
      json['youtube_us'].forEach((v) {
        youtubeUs!.add(new YoutubeUs.fromJson(v));
      });
    }
    if (json['youtube_in'] != null) {
      youtubeIn = <YoutubeIn>[];
      json['youtube_in'].forEach((v) {
        youtubeIn!.add(new YoutubeIn.fromJson(v));
      });
    }
    if (json['katha_audio'] != null) {
      kathaAudio = <KathaAudio>[];
      json['katha_audio'].forEach((v) {
        kathaAudio!.add(new KathaAudio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book!.map((v) => v.toJson()).toList();
    }
    if (this.youtubeUs != null) {
      data['youtube_us'] = this.youtubeUs!.map((v) => v.toJson()).toList();
    }
    if (this.youtubeIn != null) {
      data['youtube_in'] = this.youtubeIn!.map((v) => v.toJson()).toList();
    }
    if (this.kathaAudio != null) {
      data['katha_audio'] = this.kathaAudio!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  String? id;
  String? name;
  String? thumbnail;
  String? link;
  Null? time;
  Null? view;
  Null? audioType;
  Null? singerName;
  Null? fileName;
  String? type;

  Book(
      {this.id,
      this.name,
      this.thumbnail,
      this.link,
      this.time,
      this.view,
      this.audioType,
      this.singerName,
      this.fileName,
      this.type});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    time = json['time'];
    view = json['view'];
    audioType = json['audio_type'];
    singerName = json['singer_name'];
    fileName = json['file_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['time'] = this.time;
    data['view'] = this.view;
    data['audio_type'] = this.audioType;
    data['singer_name'] = this.singerName;
    data['file_name'] = this.fileName;
    data['type'] = this.type;
    return data;
  }
}

class YoutubeUs {
  String? id;
  String? name;
  String? thumbnail;
  String? link;
  String? time;
  String? view;
  Null? audioType;
  Null? singerName;
  Null? fileName;
  String? type;

  YoutubeUs(
      {this.id,
      this.name,
      this.thumbnail,
      this.link,
      this.time,
      this.view,
      this.audioType,
      this.singerName,
      this.fileName,
      this.type});

  YoutubeUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    time = json['time'];
    view = json['view'];
    audioType = json['audio_type'];
    singerName = json['singer_name'];
    fileName = json['file_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['time'] = this.time;
    data['view'] = this.view;
    data['audio_type'] = this.audioType;
    data['singer_name'] = this.singerName;
    data['file_name'] = this.fileName;
    data['type'] = this.type;
    return data;
  }
}

class KathaAudio {
  String? id;
  String? name;
  String? thumbnail;
  String? link;
  Null? time;
  Null? view;
  String? audioType;
  String? singerName;
  String? fileName;
  String? type;

  KathaAudio(
      {this.id,
      this.name,
      this.thumbnail,
      this.link,
      this.time,
      this.view,
      this.audioType,
      this.singerName,
      this.fileName,
      this.type});

  KathaAudio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    time = json['time'];
    view = json['view'];
    audioType = json['audio_type'];
    singerName = json['singer_name'];
    fileName = json['file_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['time'] = this.time;
    data['view'] = this.view;
    data['audio_type'] = this.audioType;
    data['singer_name'] = this.singerName;
    data['file_name'] = this.fileName;
    data['type'] = this.type;
    return data;
  }
}
class YoutubeIn {
  String? id;
  String? name;
  String? thumbnail;
  String? link;
  String? time;
  String? view;
  Null? audioType;
  Null? singerName;
  Null? fileName;
  String? type;

  YoutubeIn(
      {this.id,
      this.name,
      this.thumbnail,
      this.link,
      this.time,
      this.view,
      this.audioType,
      this.singerName,
      this.fileName,
      this.type});

  YoutubeIn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    time = json['time'];
    view = json['view'];
    audioType = json['audio_type'];
    singerName = json['singer_name'];
    fileName = json['file_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['time'] = this.time;
    data['view'] = this.view;
    data['audio_type'] = this.audioType;
    data['singer_name'] = this.singerName;
    data['file_name'] = this.fileName;
    data['type'] = this.type;
    return data;
  }
}
