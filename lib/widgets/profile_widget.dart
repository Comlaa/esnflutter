import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  var ime = "Haris";
  var prezime = "Mlaco";
  var email = "harismlaco@gmail.com";
  var spol;
//TODO - FINISH TILL THE END OF THE DAY. napraviti backend pa povezati sve.
  ProfileWidget(this.ime, this.prezime, this.email, this.spol);

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
              child: spol == true
                  ? Image.network(
                      "https://images.theconversation.com/files/393213/original/file-20210401-13-1w9xb24.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=754&h=503&fit=crop&dpr=1",
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      "https://dxgh891opzso3.cloudfront.net/files/5/9/6/9/2/shutterstock_1045743757.jpg?height=2000&width=3000",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20),
            child: Text(
              "Pozdrav " + ime.toString() + " " + prezime.toString() + "!",
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
