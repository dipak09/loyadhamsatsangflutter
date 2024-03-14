

class TodaysBhajan {
  dynamic date;
  dynamic title;
  dynamic description;
  dynamic icon;


  TodaysBhajan(
      {this.date,
        this.title,
        this.description,
        this.icon,
        });

  TodaysBhajan.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['title'] = this.title;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}


