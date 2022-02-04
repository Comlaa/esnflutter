import 'dart:convert';
import 'dart:html';
import 'package:esnflutter/models/article_comments.dart';
import 'package:esnflutter/models/fixture_model.dart';
import 'package:esnflutter/widgets/comment_widget.dart';
import 'package:esnflutter/widgets/fixture_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

Future<List<Widget>> getfixtures() async {
  final response = await ApiService.get("Fixture", "fixtures");
  
  var responseList = jsonDecode(response.body);
  List<Widget> fixtures = [];
  if (response.statusCode == 200) {
    for (var comment in responseList) {
      var loadedFixtures = FixtureModel.fromJson(comment);
      fixtures.add(
        FixtureWidget(loadedFixtures.team1, loadedFixtures.team2, loadedFixtures.result, loadedFixtures.matchTime, loadedFixtures.categoryName)
      );
    }
    return fixtures;
  } else {
    throw Exception('Greška prilikom učitavanja rezultata.');
  }
}

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({Key? key}) : super(key: key);

  @override
  _FixturesScreenState createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  Future<List<Widget>> fixtures = getfixtures();
  @override
  initState() {
    super.initState();
    fixtures = getfixtures();
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
            future: fixtures,
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
                  return const Text('Greška prilikom učitavanja rezultata.');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      Text(
                        "Rezultati",
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
                  return const Text('Nema aktivnih rezultata.');
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
