import 'dart:convert';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

Future<http.Response> Register(String email, String password, String username,
    String firstname, String lastname, int gender) {
  return http.post(
    Uri.parse('http://127.0.0.1:8012/User/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'genderId': gender
    }),
  );
}

class _SignUpScreenState extends State<SignUpScreen> {
  final email = TextEditingController();
  final username = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  int gender = 0;
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 70),
              height: 100,
              child: Text(
                "Registracija",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: password,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Lozinka',
                hintText: 'Unesite lozinku',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: username,
              decoration: InputDecoration(
                labelText: 'Korisničko ime',
                hintText: 'Unesite Vaše korisničko ime',
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
              controller: firstname,
              decoration: InputDecoration(
                labelText: 'Ime',
                hintText: 'Unesite Vaše ime',
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
              controller: lastname,
              decoration: InputDecoration(
                labelText: 'Prezime',
                hintText: 'Unesite Vaše prezime',
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
          Center(
            child: GenderPickerWithImage(
              showOtherGender: false,
              verticalAlignedText: false,
              selectedGender: Gender.Male,
              selectedGenderTextStyle:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              unSelectedGenderTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
              equallyAligned: true,
              animationDuration: Duration(milliseconds: 300),
              onChanged: (value) => {gender = value!.index, print(gender)},
              isCircular: true,
              opacityOfGradient: 0.4,
              padding: const EdgeInsets.all(3),
              size: 60, //default : 40
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: InkWell(
                onTap: () async {
                  var response = await Register(email.text, password.text,
                      username.text, firstname.text, lastname.text, gender + 1);
                  if (response.body.contains("true")) {
                    Widget okButton = TextButton(
                      child: Text("Nazad na login"),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Registracija uspješna."),
                      content: Text("Vratite se na login."),
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
                      title: Text("Registracija neuspješna."),
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
                      "Registruj se",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
