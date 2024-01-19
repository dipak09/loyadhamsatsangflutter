class CalenderData {
  List<Calender>? calender;

  CalenderData({this.calender});

  CalenderData.fromJson(Map<String, dynamic> json) {
    if (json['calender'] != null) {
      calender = <Calender>[];
      json['calender'].forEach((v) {
        calender!.add(new Calender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.calender != null) {
      data['calender'] = this.calender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Calender {
  String? id;
  String? icDate;
  String? samvatYear;
  String? sunrise;
  String? sunset;
  String? monthTitleEng;
  String? monthTitleGuj;
  String? chandraTitleEng;
  String? chandraTitleGuj;
  String? nakshatraTitleEng;
  String? nakshatraTitleGuj;
  String? pakshaTitleEng;
  String? pakshaTitleGuj;
  String? rutuTitleEng;
  String? rutuTitleGuj;
  String? tithiTitleEng;
  String? tithiTitleGuj;
  List<CalenderEvent>? calenderEvent;

  Calender(
      {this.id,
      this.icDate,
      this.samvatYear,
      this.sunrise,
      this.sunset,
      this.monthTitleEng,
      this.monthTitleGuj,
      this.chandraTitleEng,
      this.chandraTitleGuj,
      this.nakshatraTitleEng,
      this.nakshatraTitleGuj,
      this.pakshaTitleEng,
      this.pakshaTitleGuj,
      this.rutuTitleEng,
      this.rutuTitleGuj,
      this.tithiTitleEng,
      this.tithiTitleGuj,
      this.calenderEvent});

  Calender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icDate = json['ic_date'];
    samvatYear = json['samvat_year'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    monthTitleEng = json['month_title_eng'];
    monthTitleGuj = json['month_title_guj'];
    chandraTitleEng = json['chandra_title_eng'];
    chandraTitleGuj = json['chandra_title_guj'];
    nakshatraTitleEng = json['nakshatra_title_eng'];
    nakshatraTitleGuj = json['nakshatra_title_guj'];
    pakshaTitleEng = json['paksha_title_eng'];
    pakshaTitleGuj = json['paksha_title_guj'];
    rutuTitleEng = json['rutu_title_eng'];
    rutuTitleGuj = json['rutu_title_guj'];
    tithiTitleEng = json['tithi_title_eng'];
    tithiTitleGuj = json['tithi_title_guj'];
    if (json['calender_event'] != null) {
      calenderEvent = <CalenderEvent>[];
      json['calender_event'].forEach((v) {
        calenderEvent!.add(new CalenderEvent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_date'] = this.icDate;
    data['samvat_year'] = this.samvatYear;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['month_title_eng'] = this.monthTitleEng;
    data['month_title_guj'] = this.monthTitleGuj;
    data['chandra_title_eng'] = this.chandraTitleEng;
    data['chandra_title_guj'] = this.chandraTitleGuj;
    data['nakshatra_title_eng'] = this.nakshatraTitleEng;
    data['nakshatra_title_guj'] = this.nakshatraTitleGuj;
    data['paksha_title_eng'] = this.pakshaTitleEng;
    data['paksha_title_guj'] = this.pakshaTitleGuj;
    data['rutu_title_eng'] = this.rutuTitleEng;
    data['rutu_title_guj'] = this.rutuTitleGuj;
    data['tithi_title_eng'] = this.tithiTitleEng;
    data['tithi_title_guj'] = this.tithiTitleGuj;
    if (this.calenderEvent != null) {
      data['calender_event'] =
          this.calenderEvent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalenderEvent {
  String? calenderId;
  String? vratUtsavNameEng;
  String? vratUtsavNameGuj;
  Null? utsavTime;
  Null? descriptionEng;
  Null? descriptionGuj;
  String? icon;

  CalenderEvent(
      {this.calenderId,
      this.vratUtsavNameEng,
      this.vratUtsavNameGuj,
      this.utsavTime,
      this.descriptionEng,
      this.descriptionGuj,
      this.icon});

  CalenderEvent.fromJson(Map<String, dynamic> json) {
    calenderId = json['calender_id'];
    vratUtsavNameEng = json['vrat_Utsav_Name_Eng'];
    vratUtsavNameGuj = json['vrat_Utsav_Name_Guj'];
    utsavTime = json['utsav_time'];
    descriptionEng = json['description_Eng'];
    descriptionGuj = json['description_Guj'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calender_id'] = this.calenderId;
    data['vrat_Utsav_Name_Eng'] = this.vratUtsavNameEng;
    data['vrat_Utsav_Name_Guj'] = this.vratUtsavNameGuj;
    data['utsav_time'] = this.utsavTime;
    data['description_Eng'] = this.descriptionEng;
    data['description_Guj'] = this.descriptionGuj;
    data['icon'] = this.icon;
    return data;
  }
}
