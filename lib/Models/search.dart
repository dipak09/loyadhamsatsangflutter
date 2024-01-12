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
        book!.add( Book.fromJson(v));
      });
    }
    if (json['youtube_us'] != null) {
      youtubeUs = <YoutubeUs>[];
      json['youtube_us'].forEach((v) {
        youtubeUs!.add( YoutubeUs.fromJson(v));
      });
    }
    if (json['youtube_in'] != null) {
      youtubeIn = <YoutubeIn>[];
      json['youtube_in'].forEach((v) {
        youtubeIn!.add( YoutubeIn.fromJson(v));
      });
    }
    if (json['katha_audio'] != null) {
      kathaAudio = <KathaAudio>[];
      json['katha_audio'].forEach((v) {
        kathaAudio!.add( KathaAudio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  String? coverImage;
  String? uploadPdf;
  String? type;

  Book({this.id, this.name, this.coverImage, this.uploadPdf, this.type});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverImage = json['cover_image'];
    uploadPdf = json['upload_pdf'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_image'] = this.coverImage;
    data['upload_pdf'] = this.uploadPdf;
    data['type'] = this.type;
    return data;
  }
}

class YoutubeUs {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? time;
  String? view;
  String? type;

  YoutubeUs(
      {this.title,
      this.thumbnail,
      this.youtubeLink,
      this.time,
      this.view,
      this.type});

  YoutubeUs.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    youtubeLink = json['youtube_link'];
    time = json['time'];
    view = json['view'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['youtube_link'] = this.youtubeLink;
    data['time'] = this.time;
    data['view'] = this.view;
    data['type'] = this.type;
    return data;
  }
}
class YoutubeIn {
  String? title;
  String? thumbnail;
  String? youtubeLink;
  String? time;
  String? view;
  String? type;

  YoutubeIn(
      {this.title,
      this.thumbnail,
      this.youtubeLink,
      this.time,
      this.view,
      this.type});

  YoutubeIn.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    youtubeLink = json['youtube_link'];
    time = json['time'];
    view = json['view'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['youtube_link'] = this.youtubeLink;
    data['time'] = this.time;
    data['view'] = this.view;
    data['type'] = this.type;
    return data;
  }
}

class KathaAudio {
  String? id;
  String? name;
  String? audioType;
  String? singerName;
  String? coverImage;
  String? fileName;
  String? audioFile;
  String? type;

  KathaAudio(
      {this.id,
      this.name,
      this.audioType,
      this.singerName,
      this.coverImage,
      this.fileName,
      this.audioFile,
      this.type});

  KathaAudio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    audioType = json['audio_type'];
    singerName = json['singer_name'];
    coverImage = json['cover_image'];
    fileName = json['file_name'];
    audioFile = json['audio_file'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['audio_type'] = this.audioType;
    data['singer_name'] = this.singerName;
    data['cover_image'] = this.coverImage;
    data['file_name'] = this.fileName;
    data['audio_file'] = this.audioFile;
    data['type'] = this.type;
    return data;
  }
}
