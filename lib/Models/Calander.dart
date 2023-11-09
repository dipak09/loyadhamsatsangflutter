class CalenderData {
  int? icId;
  DateTime? icDate;
  String? samvatYear;
  String? monthId;
  String? adhik;
  String? pakshaId;
  dynamic pakshaIdTwo;
  String? tithiId;
  dynamic tithiIdTwo;
  String? chandraId;
  String? nakshatraId;
  dynamic nakshatraIdTwo;
  String? sunrise;
  String? sunset;
  dynamic chandraDescription;
  String? rutuId;
  dynamic descriptionGuj;
  dynamic shortDescriptionGuj;
  dynamic descriptionEng;
  dynamic shortDescriptionEng;
  String? yogId;
  String? yogTime;
  dynamic yogIdTwo;
  String? yogTimeTwo;
  dynamic icon;
  String? monthTitleEng;
  String? monthTitleGuj;
  String? chandraTitleEng;
  String? chandraTitleGuj;
  String? nakshatraTitleEng;
  String? nakshatraTitleGuj;
  dynamic nakshatraTitleEngTwo;
  dynamic nakshatraTitleGujTwo;
  String? pakshaTitleEng;
  String? pakshaTitleGuj;
  dynamic pakshaTitleEngTwo;
  dynamic pakshaTitleGujTwo;
  String? rutuTitleEng;
  String? rutuTitleGuj;
  String? tithiTitleEng;
  String? tithiTitleGuj;
  dynamic tithiTitleEngTwo;
  dynamic tithiTitleGujTwo;
  List<dynamic>? events;
  bool? isAllDay;

  CalenderData({
    this.icId,
    this.icDate,
    this.samvatYear,
    this.monthId,
    this.adhik,
    this.pakshaId,
    this.pakshaIdTwo,
    this.tithiId,
    this.tithiIdTwo,
    this.chandraId,
    this.nakshatraId,
    this.nakshatraIdTwo,
    this.sunrise,
    this.sunset,
    this.chandraDescription,
    this.rutuId,
    this.descriptionGuj,
    this.shortDescriptionGuj,
    this.descriptionEng,
    this.shortDescriptionEng,
    this.yogId,
    this.yogTime,
    this.yogIdTwo,
    this.yogTimeTwo,
    this.icon,
    this.isAllDay,
    this.monthTitleEng,
    this.monthTitleGuj,
    this.chandraTitleEng,
    this.chandraTitleGuj,
    this.nakshatraTitleEng,
    this.nakshatraTitleGuj,
    this.nakshatraTitleEngTwo,
    this.nakshatraTitleGujTwo,
    this.pakshaTitleEng,
    this.pakshaTitleGuj,
    this.pakshaTitleEngTwo,
    this.pakshaTitleGujTwo,
    this.rutuTitleEng,
    this.rutuTitleGuj,
    this.tithiTitleEng,
    this.tithiTitleGuj,
    this.tithiTitleEngTwo,
    this.tithiTitleGujTwo,
    this.events,
  });

  factory CalenderData.fromJson(Map<String, dynamic> json) => CalenderData(
        icId: json["ic_id"],
        icDate:
            json["ic_date"] == null ? null : DateTime.parse(json["ic_date"]),
        samvatYear: json["samvat_year"],
        monthId: json["month_id"],
        adhik: json["adhik"],
        pakshaId: json["paksha_id"],
        pakshaIdTwo: json["paksha_id_two"],
        tithiId: json["tithi_id"],
        tithiIdTwo: json["tithi_id_two"],
        chandraId: json["chandra_id"],
        nakshatraId: json["nakshatra_id"],
        nakshatraIdTwo: json["nakshatra_id_two"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        chandraDescription: json["chandraDescription"],
        rutuId: json["rutu_id"],
        descriptionGuj: json["description_guj"],
        shortDescriptionGuj: json["short_description_guj"],
        descriptionEng: json["description_eng"],
        shortDescriptionEng: json["short_description_eng"],
        yogId: json["yog_id"],
        yogTime: json["yog_time"],
        yogIdTwo: json["yog_id_two"],
        yogTimeTwo: json["yog_time_two"],
        icon: json["icon"],
        monthTitleEng: json["month_title_eng"],
        monthTitleGuj: json["month_title_guj"],
        chandraTitleEng: json["chandra_title_eng"],
        chandraTitleGuj: json["chandra_title_guj"],
        nakshatraTitleEng: json["nakshatra_title_eng"],
        nakshatraTitleGuj: json["nakshatra_title_guj"],
        nakshatraTitleEngTwo: json["nakshatra_title_eng_two"],
        nakshatraTitleGujTwo: json["nakshatra_title_guj_two"],
        pakshaTitleEng: json["paksha_title_eng"],
        pakshaTitleGuj: json["paksha_title_guj"],
        pakshaTitleEngTwo: json["paksha_title_eng_two"],
        pakshaTitleGujTwo: json["paksha_title_guj_two"],
        rutuTitleEng: json["rutu_title_eng"],
        rutuTitleGuj: json["rutu_title_guj"],
        tithiTitleEng: json["tithi_title_eng"],
        tithiTitleGuj: json["tithi_title_guj"],
        tithiTitleEngTwo: json["tithi_title_eng_two"],
        tithiTitleGujTwo: json["tithi_title_guj_two"],
        isAllDay: true,
        events: json["events"] == null
            ? []
            : List<dynamic>.from(json["events"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ic_id": icId,
        "ic_date":
            "${icDate!.year.toString().padLeft(4, '0')}-${icDate!.month.toString().padLeft(2, '0')}-${icDate!.day.toString().padLeft(2, '0')}",
        "samvat_year": samvatYear,
        "month_id": monthId,
        "adhik": adhik,
        "paksha_id": pakshaId,
        "paksha_id_two": pakshaIdTwo,
        "tithi_id": tithiId,
        "tithi_id_two": tithiIdTwo,
        "chandra_id": chandraId,
        "nakshatra_id": nakshatraId,
        "nakshatra_id_two": nakshatraIdTwo,
        "sunrise": sunrise,
        "sunset": sunset,
        "isAllDay": isAllDay,
        "chandraDescription": chandraDescription,
        "rutu_id": rutuId,
        "description_guj": descriptionGuj,
        "short_description_guj": shortDescriptionGuj,
        "description_eng": descriptionEng,
        "short_description_eng": shortDescriptionEng,
        "yog_id": yogId,
        "yog_time": yogTime,
        "yog_id_two": yogIdTwo,
        "yog_time_two": yogTimeTwo,
        "icon": icon,
        "month_title_eng": monthTitleEng,
        "month_title_guj": monthTitleGuj,
        "chandra_title_eng": chandraTitleEng,
        "chandra_title_guj": chandraTitleGuj,
        "nakshatra_title_eng": nakshatraTitleEng,
        "nakshatra_title_guj": nakshatraTitleGuj,
        "nakshatra_title_eng_two": nakshatraTitleEngTwo,
        "nakshatra_title_guj_two": nakshatraTitleGujTwo,
        "paksha_title_eng": pakshaTitleEng,
        "paksha_title_guj": pakshaTitleGuj,
        "paksha_title_eng_two": pakshaTitleEngTwo,
        "paksha_title_guj_two": pakshaTitleGujTwo,
        "rutu_title_eng": rutuTitleEng,
        "rutu_title_guj": rutuTitleGuj,
        "tithi_title_eng": tithiTitleEng,
        "tithi_title_guj": tithiTitleGuj,
        "tithi_title_eng_two": tithiTitleEngTwo,
        "tithi_title_guj_two": tithiTitleGujTwo,
        "events":
            events == null ? [] : List<dynamic>.from(events!.map((x) => x)),
      };
}
