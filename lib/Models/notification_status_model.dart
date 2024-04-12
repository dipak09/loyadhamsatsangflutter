class NotificationStatus {
  String id;
  String token;
  String timezone;
  bool isNotificationAllowed;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationStatus({
    required this.id,
    required this.token,
    required this.timezone,
    required this.isNotificationAllowed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationStatus.fromJson(Map<String, dynamic> json) {
    return NotificationStatus(
      id: json['id'] ?? '',
      token: json['token'] ?? '',
      timezone: json['timezone'] ?? '',
      isNotificationAllowed: json['is_notification_allow'] == 'true',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
