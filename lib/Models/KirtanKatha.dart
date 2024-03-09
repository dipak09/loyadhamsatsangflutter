class KirtanKatha {
  String? id;
  String? singerId;
  String? type;
  String? eventName;
  String? uploadFile;
  String? kathaMasterId;
  int? totalTrack;
  List<TrackList>? trackList;

  KirtanKatha(
      {this.id,
      this.singerId,
      this.type,
      this.eventName,
      this.uploadFile,
      this.kathaMasterId,
      this.totalTrack,
      this.trackList});

  KirtanKatha.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    singerId = json['singer_id'];
    type = json['type'];
    eventName = json['event_name'];
    uploadFile = json['upload_file'];
    kathaMasterId = json['katha_master_id'];
    totalTrack = json['total_track'];
    if (json['track_list'] != null) {
      trackList = <TrackList>[];
      json['track_list'].forEach((v) {
        trackList!.add(new TrackList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['singer_id'] = this.singerId;
    data['type'] = this.type;
    data['event_name'] = this.eventName;
    data['upload_file'] = this.uploadFile;
    data['katha_master_id'] = this.kathaMasterId;
    data['total_track'] = this.totalTrack;
    if (this.trackList != null) {
      data['track_list'] = this.trackList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrackList {
  String? uploadAudio;

  TrackList({this.uploadAudio});

  TrackList.fromJson(Map<String, dynamic> json) {
    uploadAudio = json['upload_audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upload_audio'] = this.uploadAudio;
    return data;
  }
}
