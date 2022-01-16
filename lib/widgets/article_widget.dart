import 'package:esnflutter/screens/article_details_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateFavorites(int articleId, bool favorite, bool saved) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id');
  http.put(
    Uri.parse('https://10.0.2.2:8012/Article/article-favorites'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'articleId': articleId,
      'userId': userId,
      'favorite': favorite,
      'saved': saved,
    }),
  );
}

class ArticleWidget extends StatefulWidget {
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
  bool saved;
  int rating;
  ArticleWidget(
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
      this.saved,
      this.rating);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Card(
        elevation: 10,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticleDetailsScreen(
                      widget.id,
                      widget.title,
                      widget.text,
                      widget.tags,
                      widget.category,
                      widget.articleComments,
                      widget.articleRating,
                      widget.comments,
                      widget.picture,
                      widget.favorite,
                      widget.saved,
                      widget.rating)));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: size.width,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: size.width,
                      height: 140,
                      child: Image.memory(base64Decode(widget.picture),
                          fit: BoxFit.fill)),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 10,
                      left: 10,
                      bottom: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.favorite =
                                      widget.favorite ? false : true;
                                  updateFavorites(
                                      widget.id, widget.favorite, widget.saved);
                                });
                              },
                              child: widget.favorite
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.saved = widget.saved ? false : true;
                                  updateFavorites(
                                      widget.id, widget.favorite, widget.saved);
                                });
                              },
                              child: widget.saved
                                  ? Icon(Icons.bookmark)
                                  : Icon(Icons.bookmark_border),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
