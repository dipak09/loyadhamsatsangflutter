//
//
// class TodaysBhajan {
//   dynamic date;
//   dynamic title;
//   dynamic description;
//   dynamic icon;
//
//
//   TodaysBhajan(
//       {this.date,
//         this.title,
//         this.description,
//         this.icon,
//         });
//
//   TodaysBhajan.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     title = json['title'];
//     description = json['description'];
//     icon = json['icon'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['icon'] = this.icon;
//     return data;
//   }
// }
//
//


class TodayBhajan {
  String? id;
  String? categoryName;
  String? image;
  String? bhajanName;

  TodayBhajan({this.id, this.categoryName, this.image, this.bhajanName});

  TodayBhajan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    image = json['image'];
    bhajanName = json['bhajan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['image'] = this.image;
    data['bhajan_name'] = this.bhajanName;
    return data;
  }
}
