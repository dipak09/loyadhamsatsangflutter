class NotificationModel {
  List<Notification>? notification;

  NotificationModel({this.notification});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(new Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String? eventDate;
  String? notificationDate;
  String? englishMsg;
  String? gujaratiMsg;
  String? icon;

  Notification(
      {this.eventDate,
      this.notificationDate,
      this.englishMsg,
      this.gujaratiMsg,
      this.icon});

  Notification.fromJson(Map<String, dynamic> json) {
    eventDate = json['event_date'];
    notificationDate = json['notification_date'];
    englishMsg = json['english_msg'];
    gujaratiMsg = json['gujarati_msg'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_date'] = this.eventDate;
    data['notification_date'] = this.notificationDate;
    data['english_msg'] = this.englishMsg;
    data['gujarati_msg'] = this.gujaratiMsg;
    data['icon'] = this.icon;
    return data;
  }
}
