import 'dart:convert';
import 'package:esnflutter/models/article.dart';
import 'package:esnflutter/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

Future<List<Widget>> getArticles() async {
  final response = await ApiService.getWithUserId("Article", "recommended-articles");
 
  var responseList = jsonDecode(response.body);
  List<Widget> articles = [];
  if (response.statusCode == 200) {
    for (var article in responseList) {
      var loadedArticle = Article.fromJson(article);
      articles.add(ArticleWidget(
          loadedArticle.id,
          loadedArticle.title,
          loadedArticle.text,
          loadedArticle.tags,
          loadedArticle.category,
          loadedArticle.articleComments,
          loadedArticle.articleRating,
          loadedArticle.comments,
          loadedArticle.picture,
          loadedArticle.favorite,
          loadedArticle.saved,
          loadedArticle.rating));
    }
    return articles;
  } else {
    throw Exception('Greška prilikom učitavanja preporučenih članaka.');
  }
}

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({Key? key}) : super(key: key);

  @override
  _SuggestedScreenState createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  Future<List<Widget>> articles = getArticles();
  @override
  initState() {
    super.initState();
    articles = getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 45, bottom: 25),
        width: double.infinity,
        child: Container(
          child: FutureBuilder<List<Widget>>(
            future: articles,
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
                  return const Text(
                      'Greška prilikom učitavanja preporučenih članaka.');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      Text(
                        "Preporučeni članci",
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
                  throw Exception('Greška prilikom učitavanja članaka.');
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
