import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:manning_live/services/algolia/algolia_service.dart';
import 'package:manning_live/services/system/preferences_service.dart';
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';
import 'package:manning_live/stores/authentication_store.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/search_store.dart';
import 'package:manning_live/stores/settings_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';
import 'themeable_navigation_app.dart';

class App extends StatelessWidget {
  final PreferencesService _preferencesService;
  final FirestoreRepositoryService _postService;
  final AlgoliaService _algoliaService;

  const App(this._preferencesService, this._postService, this._algoliaService);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesService>(
          builder: (_) => _preferencesService,
        ),
        Provider<FirestoreRepositoryService>(
          builder: (_) => _postService,
        ),
        Provider<AlgoliaService>(
          builder: (_) => _algoliaService,
        ),
        Provider<SettingsStore>(
          builder: (_) => SettingsStore(_preferencesService),
        ),
        Provider<AuthenticationStore>(
          builder: (_) => AuthenticationStore(_preferencesService),
        ),
        Provider<FavoritesStore>(
          builder: (_) => FavoritesStore(_preferencesService, _postService),
        ),
        Provider<ViewsStore>(
          builder: (_) => ViewsStore(_preferencesService, _postService),
        ),
        Provider<SearchStore>(
          builder: (_) => SearchStore(_algoliaService, _preferencesService),
        ),
        Provider<StoriesStore>(
          builder: (_) => StoriesStore(_postService, _preferencesService),
        ),
        Provider<SharingService>(
          builder: (_) => SharingService(),
        ),
      ],
      child: Consumer<SettingsStore>(
        builder: (context, value, _) => ThemeableNavigationApp(value),
      ),
    );
  }
}
