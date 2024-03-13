

class TodaysBhajan {
  String? date;
  String? title;
  String? description;


  TodaysBhajan(
      {this.date,
        this.title,
        this.description,
        });

  TodaysBhajan.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}


