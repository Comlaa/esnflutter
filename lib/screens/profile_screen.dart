import 'dart:convert';
import 'package:esnflutter/models/article.dart';
import 'package:esnflutter/models/user_data.dart';
import 'package:esnflutter/widgets/article_widget.dart';
import 'package:esnflutter/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Widget>> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id');
  final response = await http.get(
      Uri.parse('https://10.0.2.2:8012/User/user?userId=' + userId.toString()));
  var responseList = jsonDecode(response.body);
  List<Widget> userData = [];
  if (response.statusCode == 200) {
    var data = UserData.fromJson(responseList);
    var genderId = 2;
    if (data.gender.contains("Musko")) genderId = 1;
    userData.add(ProfileWidget(data.name, data.username, data.email, genderId));
    return userData;
  } else {
    throw Exception('Greška prilikom učitavanja podataka.');
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<List<Widget>> userData = getUserData();
  @override
  initState() {
    super.initState();
    userData = getUserData();
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
            future: userData,
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
                  return const Text('Greška prilikom učitavanja podataka.');
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
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
