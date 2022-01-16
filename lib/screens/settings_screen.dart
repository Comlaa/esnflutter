import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ime = TextEditingController();
  final prezime = TextEditingController();
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
              controller: email,
              decoration: InputDecoration(
                labelText: 'Ime',
                hintText: 'Enter your name',
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
              controller: prezime,
              decoration: InputDecoration(
                labelText: 'Prezime',
                hintText: 'Enter your surname',
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
                hintText: 'Enter your email',
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
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Change",
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  width: 350,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Sign out",
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10, right: 15.0, left: 15, bottom: 15),
            child: Center(
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  width: 350,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Deaktiviraj account",
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
