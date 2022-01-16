import 'dart:convert';
import 'package:esnflutter/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> AddComment(int articleId, String comment) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id');
  return http.put(
    Uri.parse('https://10.0.2.2:8012/Article/article-comment'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'articleId': articleId,
      'userId': userId,
      'comment': comment
    }),
  );
}

Future<http.Response> AddRating(int articleId, int rating) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id');
  return http.put(
    Uri.parse('https://10.0.2.2:8012/Article/article-rating'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'articleId': articleId,
      'userId': userId,
      'rating': rating
    }),
  );
}

class ArticleDetailsScreen extends StatelessWidget {
  final int id;
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
  int rating;
  final komentar = TextEditingController();

  ArticleDetailsScreen(
      this.id,
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
      this.rating);
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
                    Navigator.pop(context);
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: komentar,
                decoration: InputDecoration(
                  labelText: 'Komentar',
                  hintText: 'Dodajte komentar',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    await AddComment(id, komentar.text);

                    Widget okButton = TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Operacija uspješna!"),
                      content: Text("Vaš komentar je uspješno dodan."),
                      actions: [
                        okButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Dodaj komentar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
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
                    onTap: () async {
                      await addRating(context, 1);
                    },
                    child: rating >= 1
                        ? Icon(Icons.star, color: Colors.blue.shade300)
                        : Icon(Icons.star_border, color: Colors.blue.shade300)),
                InkWell(
                    onTap: () async {
                      await addRating(context, 2);
                    },
                    child: rating >= 2
                        ? Icon(Icons.star, color: Colors.blue.shade300)
                        : Icon(Icons.star_border, color: Colors.blue.shade300)),
                InkWell(
                    onTap: () async {
                      await addRating(context, 3);
                    },
                    child: rating >= 3
                        ? Icon(Icons.star, color: Colors.blue.shade300)
                        : Icon(Icons.star_border, color: Colors.blue.shade300)),
                InkWell(
                    onTap: () async {
                      await addRating(context, 4);
                    },
                    child: rating >= 4
                        ? Icon(Icons.star, color: Colors.blue.shade300)
                        : Icon(Icons.star_border, color: Colors.blue.shade300)),
                InkWell(
                    onTap: () async {
                      await addRating(context, 5);
                    },
                    child: rating == 5
                        ? Icon(Icons.star, color: Colors.blue.shade300)
                        : Icon(Icons.star_border, color: Colors.blue.shade300)),
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

  Future<void> addRating(BuildContext context, int rating) async {
    await AddRating(id, rating);

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Operacija uspješna!"),
      content: Text("Uspješno ste ocijenili artikal!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
