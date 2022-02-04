class NotificationModel {
  final String title;
  final bool read;

  NotificationModel({
    required this.title,
    required this.read,
  });

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'],
        read = json['read'];
}
