import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

Future<http.Response> Edit(String email, String username, String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = await prefs.getInt('id');
  return http.put(
    Uri.parse('http://127.0.0.1:8012/User/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'username': username,
      'email': email,
      'name': name,
      'id': userId,
      'gender': 'Musko'
    }),
  );
}

class _SettingsScreenState extends State<SettingsScreen> {
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 30),
              height: 100,
              child: Text(
                "Postavke",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: name,
              decoration: InputDecoration(
                labelText: 'Ime',
                hintText: 'Unesite novo ime',
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
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: username,
              decoration: InputDecoration(
                labelText: 'Korisničko ime',
                hintText: 'Unesite novi korisničko ime',
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
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Unesite novi email',
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
                  var response =
                      await Edit(email.text, username.text, name.text);
                  if (response.body.contains("true")) {
                    Widget okButton = TextButton(
                      child: Text("Nazad na postavke"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Promjena uspješna."),
                      content: Text("Vratite se na postavke."),
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
                      title: Text("Promjena neuspješna."),
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
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Snimi",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 60, right: 15.0, left: 15, bottom: 5),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  width: 350,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Odjavi se",
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
