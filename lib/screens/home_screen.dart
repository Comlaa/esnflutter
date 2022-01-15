import 'package:esnflutter/models/article.dart';
import 'package:esnflutter/models/screen_navigation.dart';
import 'package:esnflutter/screens/articles_screen.dart';
import 'package:esnflutter/screens/comments_screen.dart';
import 'package:esnflutter/screens/favorites_screen.dart';
import 'package:esnflutter/screens/login_screen.dart';
import 'package:esnflutter/screens/options_screen.dart';
import 'package:esnflutter/screens/saved_screen.dart';
import 'package:esnflutter/screens/signup_screen.dart';
import 'package:esnflutter/screens/suggested_screen.dart';
import 'package:esnflutter/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    const LoginScreen(),
    const ArticlesScreen(),
    const FavoritesScreen(),
    const SavedScreen(),
    const CommentsScreen(),
    const OptionsScreen(),
    const SuggestedScreen(),
    const SignUpScreen(),
  ];

  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.text_snippet_sharp),
                selectedIcon: Icon(Icons.text_snippet_sharp),
                label: Text('News'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Liked'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Bookmared'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.insert_comment),
                selectedIcon: Icon(Icons.insert_comment_rounded),
                label: Text('Comments'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_outline_outlined),
                selectedIcon: Icon(Icons.star),
                label: Text('Favorites'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_applications_outlined),
                selectedIcon: Icon(Icons.settings_applications),
                label: Text('Settings'),
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
