import 'dart:convert';
import 'package:esnflutter/models/article_comments.dart';
import 'package:esnflutter/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

Future<List<Widget>> getComments() async {
  final response = await ApiService.getWithUserId("Article", "comments");
  
  var responseList = jsonDecode(response.body);
  List<Widget> comments = [];
  if (response.statusCode == 200) {
    for (var comment in responseList) {
      var loadedCommnets = ArticleComments.fromJson(comment);
      comments.add(
        CommentWidget(loadedCommnets.name, loadedCommnets.comment, 100, 300),
      );
    }
    return comments;
  } else {
    throw Exception('Greška prilikom učitavanja komentara.');
  }
}

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  Future<List<Widget>> comments = getComments();
  @override
  initState() {
    super.initState();
    comments = getComments();
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
            future: comments,
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
                  return const Text('Greška prilikom učitavanja komentara.');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      Text(
                        "Komentari",
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
                  return const Text('Nemate aktivnih komentara.');
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
