import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:manning_live/screens/favorites_page.dart';
import 'package:manning_live/screens/search_page.dart';
import 'package:manning_live/screens/settings_page.dart';
import 'package:manning_live/screens/stories_page.dart';
import 'package:manning_live/stores/authentication_store.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/search_store.dart';
import 'package:manning_live/stores/settings_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'manning',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Lato',
                      color: Colors.black)),
              TextSpan(
                  text: 'live',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      color: Colors.black)),
            ],
          ),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                activeIcon: Icon(Icons.bookmark),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return Consumer2<StoriesStore, ViewsStore>(
                  builder: (context, storiesStore, viewsStore, _) => Material(
                    child: StoriesPage(storiesStore, viewsStore),
                  ),
                );
              case 1:
                return Consumer3<SearchStore, StoriesStore, ViewsStore>(
                  builder:
                      (context, searchStore, storiesStore, viewsStore, _) =>
                          Material(
                    child: SearchPage(searchStore, storiesStore, viewsStore),
                  ),
                );
              case 2:
                return Consumer<FavoritesStore>(
                  builder: (context, value, _) => Material(
                    child: FavoritesPage(value),
                  ),
                );
              case 3:
                return Consumer3<SettingsStore, AuthenticationStore, ViewsStore>(
                      builder: (context, settingsStore, authenticationStore, viewsStore, _) => Material(
                            child: SettingsPage(settingsStore, authenticationStore, viewsStore),
                          ),
                    );
            }
            return null;
          },
        ),
      ),
    );
  }
}
