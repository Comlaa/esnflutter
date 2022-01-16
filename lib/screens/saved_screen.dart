import 'dart:convert';
import 'package:esnflutter/models/article-lite.dart';
import 'package:esnflutter/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Widget>> getArticles() async {
  final response = await http
      .get(Uri.parse('https://10.0.2.2:8012/Article/saved-articles?userId=3'));

  var responseList = jsonDecode(response.body);
  List<Widget> articles = [];
  if (response.statusCode == 200) {
    for (var article in responseList) {
      var loadedArticle = ArticleLite.fromJson(article);
      articles.add(ArticleWidget(loadedArticle.title, loadedArticle.picture,
          loadedArticle.favorite, loadedArticle.saved));
    }
    return articles;
  } else {
    throw Exception('Greška prilikom učitavanja članaka.');
  }
}

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
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
                  return const Text('Greška prilikom učitavanja članaka.');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      Text("Omiljeni članci"),
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
