import 'dart:convert';
import 'dart:io';

import 'package:esnflutter/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> MarkNotificationAsRead(int notificationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id') ?? 0;
  var basicAuth = await prefs.getString('basicAuth');

  return http.put(
    Uri.parse('http://127.0.0.1:8012/Notification/notification'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: basicAuth!
    },
    body: jsonEncode(
        <String, int>{'notificationId': notificationId, 'userId': userId}),
  );
}

class NotificationWidget extends StatefulWidget {
  final String title;
  final bool read;
  final int notificationId;

  NotificationWidget(this.title, this.read, this.notificationId);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Card(
        color: widget.read ? Colors.blue.shade200 : Colors.red.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          height: 100,
          width: 300,
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    onTap: () async {
                      var wait = await MarkNotificationAsRead(widget.notificationId);
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NotificationsScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      width: 140,
                      height: 25,
                      child: Center(
                        child: Text(
                          widget.read ? "Notifikacija pročitana" : "Označi kao pročitano",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
