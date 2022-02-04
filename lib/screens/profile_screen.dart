import 'dart:convert';
import 'dart:io';
import 'package:esnflutter/models/user_data.dart';
import 'package:esnflutter/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

Future<List<Widget>> getUserData() async {
  final response = await ApiService.getWithUserId("User", "user");
  
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

Future<http.Response> SendSupportTicket(String email, String text) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id');
  var basicAuth = await prefs.getString('basicAuth');

  return http.post(
    Uri.parse('http://127.0.0.1:8012/User/support-ticket'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: basicAuth!
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'userId': userId,
      'text': text,
      'name':''
    }),
  );
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
  final email = TextEditingController();
  final text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40, bottom: 25),
        child: Column(
          children: [
            Container(
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
                      throw Exception('Greška prilikom učitavanja podataka.');
                    }
                  } else {
                    throw Exception('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
            Center(
            child: Container(
              padding: EdgeInsets.only(top: 50),
              height: 100,
              child: Text(
                "Imate problem?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              height: 100,
              child: Text(
                "Korisnička podrška",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left:20),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Unesite Vaš email',
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
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: text,
              decoration: InputDecoration(
                labelText: 'Opis problema',
                hintText: 'Opišite nam Vaš problem',
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
          ),Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: InkWell(
                onTap: () async {
                  var response = await SendSupportTicket(email.text, text.text);
                  if (response.body.contains("true")) {
                    Widget okButton = TextButton(
                      child: Text("Nazad na profil"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Operacija uspješna"),
                      content: Text("Uspješno ste poslali tiket."),
                      actions: [
                        okButton,
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    Widget okButton = TextButton(
                      child: Text("Nazad"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Operacija neuspješna"),
                      content: Text("Molimo pokušajte ponovo."),
                      actions: [
                        okButton,
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
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
                      "Pošalji",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        ),
      ),
    );
  }
}
