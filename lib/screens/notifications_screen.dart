import 'dart:convert';
import 'package:esnflutter/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';
import '../services/api_service.dart';

Future<List<Widget>> getNotifications() async {
  final response = await ApiService.getWithUserId("Notification", "user-notifications");

  var responseList = jsonDecode(response.body);
  List<Widget> notifications = [];
  if (response.statusCode == 200) {
    for (var notification in responseList) {
      var loadedNotifications = NotificationModel.fromJson(notification);
      notifications.add(
        CommentWidget(loadedNotifications.title, "read", 100, 200),
      );
    }
    return notifications;
  } else {
    throw Exception('Greška prilikom učitavanja komentara.');
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<List<Widget>> notifications = getNotifications();
  @override
  initState() {
    super.initState();
    notifications = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: 55, bottom: 25),
        width: double.infinity,
        child: Container(
          child: FutureBuilder<List<Widget>>(
            future: notifications,
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Greška prilikom učitavanja notifikacija.');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      Text(
                        "Notifikacije",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600),
                      ),
                      Column(children: snapshot.data!),
                    ],
                  ));
                } else {
                  return const Text('Nemate aktivnih notifikacija.');
                }
              } else {
                throw Exception('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}
