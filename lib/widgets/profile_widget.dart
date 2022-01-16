import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  var name;
  var username;
  var email;
  var gender;
  ProfileWidget(this.name, this.username, this.email, this.gender);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 55, bottom: 25),
          child: Container(
            child: Text(
              "Profil",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: Container(
                height: 200,
                width: 200,
                child: gender == 1
                    ? Image.asset('assets/images/male-avatar.png',
                        fit: BoxFit.fill)
                    : Image.asset('assets/images/female-avatar.png',
                        fit: BoxFit.fill)),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20),
            child: Text(
              "Pozdrav " + name.toString() + "!",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20),
            child: Text(
              "Vas username je " + username.toString() + ".",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20),
            child: Text(
              "Vas email je " + email.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        )
      ],
    );
  }
}
