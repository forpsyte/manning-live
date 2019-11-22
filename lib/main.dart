import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'services/firebase/firestore/firestore.dart';
import 'services/system/preferences_service.dart';
import 'services/algolia/algolia_service.dart';
import 'widgets/app.dart';

Future<void> main() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  await FlutterStatusbarcolor.setStatusBarColor(Colors.amber);
  if (useWhiteForeground(Colors.amber)) {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
  final postService = FirestoreRepositoryService(PostRepositoryFactory());
  runApp(App(PreferencesService(sharedPreferences), postService, AlgoliaService()));
}