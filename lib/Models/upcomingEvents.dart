

class UpcomingEvent {
  String? eventDate;
  String? vratUtsavNameEng;
  String? vratUtsavNameGuj;
  Null? utsavTime;
  Null? descriptionEng;
  Null? descriptionGuj;
  String? icon;

  UpcomingEvent(
      {this.eventDate,
      this.vratUtsavNameEng,
      this.vratUtsavNameGuj,
      this.utsavTime,
      this.descriptionEng,
      this.descriptionGuj,
      this.icon});

  UpcomingEvent.fromJson(Map<String, dynamic> json) {
    eventDate = json['event_date'];
    vratUtsavNameEng = json['vrat_Utsav_Name_Eng'];
    vratUtsavNameGuj = json['vrat_Utsav_Name_Guj'];
    utsavTime = json['utsav_time'];
    descriptionEng = json['description_Eng'];
    descriptionGuj = json['description_Guj'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_date'] = this.eventDate;
    data['vrat_Utsav_Name_Eng'] = this.vratUtsavNameEng;
    data['vrat_Utsav_Name_Guj'] = this.vratUtsavNameGuj;
    data['utsav_time'] = this.utsavTime;
    data['description_Eng'] = this.descriptionEng;
    data['description_Guj'] = this.descriptionGuj;
    data['icon'] = this.icon;
    return data;
  }
}


