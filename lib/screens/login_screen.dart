import 'dart:convert';
import 'dart:io';
import 'package:esnflutter/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:esnflutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
final String basicAuth='Basic '+base64Encode(utf8.encode('desktop:test'));
Future<http.Response> Login(String email, String password) {
  return http.put(
    Uri.parse('http://127.0.0.1:8012/User/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader:basicAuth
    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
    }),
  );
}

Future<int> getUserId(String username) async {
  final response = await http.get(
      Uri.parse('http://127.0.0.1:8012/User/user-id?username=' + username),
      headers: <String, String> {
        HttpHeaders.authorizationHeader:basicAuth
      });

  return jsonDecode(response.body);
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
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
                "Login",
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
                labelText: 'Korisničko ime',
                hintText: 'Unesite vaše korisničko ime',
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
                hintText: 'Unesite vašu lozinku',
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
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: InkWell(
                onTap: () async {
                  var response = await Login(email.text, password.text);
                  if (response.body.contains("true")) {
                    var userId = await getUserId(email.text);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt('id', userId);
                    await prefs.setString('basicAuth', basicAuth);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } else {
                    Widget okButton = TextButton(
                      child: Text("Nazad"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Text("Prijava neuspješna."),
                      content: Text(
                          "Lozinka ili korisničko ime nisu validni. Molimo pokušajte ponovo."),
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
                  width: 140,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Potvrdi",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: InkWell(
                onTap: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  "Nemate račun?",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
