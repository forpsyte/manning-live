import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/screens/loading_page.dart';
import 'package:manning_live/screens/registration_page.dart';
import 'package:manning_live/screens/story_page.dart';
import 'package:manning_live/stores/authentication_store.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/settings_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/widgets/home.dart';
import 'package:provider/provider.dart';

class ThemeableNavigationApp extends StatelessWidget {
  final SettingsStore settingsStore;
  ThemeableNavigationApp(this.settingsStore, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var themeData = ThemeData(
          fontFamily: 'Montserrat',
          brightness: settingsStore.useDarkMode == true
              ? Brightness.dark
              : Brightness.light,
          primarySwatch: Colors.amber,
          // primaryColor: Colors.white,
          primaryTextTheme: TextTheme(
            title: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.black),
            display1: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: CupertinoColors.black),
            body1: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            caption: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red[600]),
          ),
          textTheme: TextTheme(
              title: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: CupertinoColors.white),
              subhead: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              subtitle: TextStyle(fontWeight: FontWeight.w300),
              headline: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              display1: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: CupertinoColors.inactiveGray),
              display2: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.inactiveGray),
              display3: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.white),
              caption: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.white)),
          accentTextTheme: TextTheme(
            subhead: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.inactiveGray),
            headline: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            body1: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.black),
            button: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: CupertinoColors.destructiveRed),
            subtitle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.grey[400]),
            caption: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.black),
            display3: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: CupertinoColors.black),
          ),
        );
        return MaterialApp(
          title: 'Manning Live',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: Consumer<AuthenticationStore>(
            builder: (context, value, _) => Material(
              child: LoadingPage(value),
            ),
          ),
          routes: {
            '/story': (context) => Consumer2<FavoritesStore, StoriesStore>(
                  builder: (context, favoritesStore, storiesStore, _) =>
                      Material(
                    child: StoryPage(favoritesStore, storiesStore),
                  ),
                ),
            '/register': (context) => Consumer<AuthenticationStore>(
                  builder: (context, authenticationStore, _) => Material(
                    child: RegistrationPage(authenticationStore),
                  ),
                ),
            '/home': (context) => HomePage(),
          },
        );
      },
    );
  }
}
