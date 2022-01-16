import 'dart:convert';
import 'package:esnflutter/models/article_comments.dart';
import 'package:esnflutter/widgets/comment_widget.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final String title;
  final String text;
  final String tags;
  final String category;
  final List<dynamic> articleComments;
  final num articleRating;
  final String comments;
  final String picture;
  bool favorite;
  bool bookmark;

  ArticleDetailsScreen(
    this.title,
    this.text,
    this.tags,
    this.category,
    this.articleComments,
    this.articleRating,
    this.comments,
    this.picture,
    this.favorite,
    this.bookmark,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25.0,
                left: 30,
                top: 30,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blue.shade300,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 25),
                  ),
                  Row(
                    children: [
                      Text(
                        articleRating.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue.shade300,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.blue.shade300,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 2,
              width: 350,
              padding: EdgeInsets.only(bottom: 15),
              color: Colors.grey.shade400,
            ),
            Container(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              height: 250,
              width: 350,
              child: Text(
                text,
              ),
            ),
            Container(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5,
                  right: 20,
                ),
                child: Text(
                  "Album",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: 2,
              width: 350,
              padding: EdgeInsets.only(bottom: 15),
              color: Colors.grey.shade400,
            ),
            Container(
              height: 20,
            ),
            Container(
              width: 300,
              height: 200,
              child: Image.memory(base64Decode(picture), fit: BoxFit.fill),
            ),
            Container(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5,
                  right: 20,
                ),
                child: Text(
                  "Komentari",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: 2,
              width: 350,
              padding: EdgeInsets.only(bottom: 15),
              color: Colors.grey.shade400,
            ),
            Container(
              height: 20,
            ),
            Column(
              children: [
                for (var comment in articleComments)
                  CommentWidget(
                    comment["name"],
                    comment["comment"],
                    130,
                    350,
                  ),
              ],
            ),
            Container(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5,
                  right: 20,
                ),
                child: Text(
                  "Rating",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: 2,
              width: 350,
              padding: EdgeInsets.only(bottom: 15),
              color: Colors.grey.shade400,
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    Icons.star,
                    color: Colors.blue.shade300,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.star,
                    color: Colors.blue.shade300,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.star,
                    color: Colors.blue.shade300,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.star,
                    color: Colors.blue.shade300,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.star,
                    color: Colors.blue.shade300,
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
