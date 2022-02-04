class NotificationModel {
  final String title;
  final bool read;
  final int id;

  NotificationModel({
    required this.title,
    required this.read,
    required this.id,
  });

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'],
        read = json['read'],
        id = json['id'];
}
