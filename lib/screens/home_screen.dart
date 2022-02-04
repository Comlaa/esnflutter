import 'package:esnflutter/screens/articles_screen.dart';
import 'package:esnflutter/screens/comments_screen.dart';
import 'package:esnflutter/screens/favorites_screen.dart';
import 'package:esnflutter/screens/fixtures_screen.dart';
import 'package:esnflutter/screens/notifications_screen.dart';
import 'package:esnflutter/screens/profile_screen.dart';
import 'package:esnflutter/screens/saved_screen.dart';
import 'package:esnflutter/screens/settings_screen.dart';
import 'package:esnflutter/screens/signup_screen.dart';
import 'package:esnflutter/screens/suggested_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    const ProfileScreen(),
    const ArticlesScreen(),
    const FavoritesScreen(),
    const SavedScreen(),
    const CommentsScreen(),
    const SuggestedScreen(),
    const FixturesScreen(),
    const SettingsScreen(),
    const SignUpScreen(),
  ];

  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NotificationsScreen()));
        },
        child: Icon(
          Icons.circle_notifications,
          color: Colors.white,
          size: 50.0,
        ),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(), primary: Colors.blue.shade400),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NavigationRail(
            groupAlignment: -0.4,
            minWidth: 90,
            unselectedIconTheme: IconThemeData(color: Colors.white),
            selectedIconTheme: IconThemeData(color: Colors.black),
            selectedLabelTextStyle: TextStyle(color: Colors.black),
            backgroundColor: Colors.blue.shade400,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profil'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.text_snippet_sharp),
                selectedIcon: Icon(Icons.text_snippet_sharp),
                label: Text('Članci'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Favoriti'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Snimljeni'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.insert_comment),
                selectedIcon: Icon(Icons.insert_comment_rounded),
                label: Text('Komentari'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_outline_outlined),
                selectedIcon: Icon(Icons.star),
                label: Text('Preporučeno'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.sports_baseball_outlined),
                selectedIcon: Icon(Icons.sports_baseball),
                label: Text('Rezultati'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_applications_outlined),
                selectedIcon: Icon(Icons.settings_applications),
                label: Text('Postavke'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex],
          )
        ],
      ),
    );
  }
}
