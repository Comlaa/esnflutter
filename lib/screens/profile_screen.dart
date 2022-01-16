import 'package:esnflutter/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileWidget("Haris", "Mlačo", "mail@gmail.com", false),
    );
  }
}
