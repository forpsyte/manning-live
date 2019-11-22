import 'package:card_settings/card_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/stores/authentication_store.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/settings_store.dart';
import 'package:manning_live/stores/views_store.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final SettingsStore settingsStore;
  final AuthenticationStore authenticationStore;
  final ViewsStore viewsStore;

  SettingsPage(this.settingsStore, this.authenticationStore, this.viewsStore, {Key key})
      : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final FavoritesStore _favoritesStore = Provider.of<FavoritesStore>(context);
    return Observer(
      builder: (_) => Form(
        key: _formKey,
        child: CardSettings(
          children: <Widget>[
            CardSettingsHeader(label: 'Brightness'),
            CardSettingsSwitch(
              label: 'Dark Mode',
              initialValue: widget.settingsStore.useDarkMode,
              onChanged: (value) {
                widget.settingsStore.setDarkMode(value);
              },
            ),
            CardSettingsHeader(label: 'Account'),
            CardSettingsField(
              labelAlign: TextAlign.left,
              contentOnNewLine: true,
              label: 'Logged in as:',
              content: widget.authenticationStore.firebaseUser != null
                  ? Text(
                      widget.authenticationStore.firebaseUser.email,
                      textAlign: TextAlign.left,
                    )
                  : Container(),
            ),
            CardSettingsText(label: "Display Name", icon: Icon(Icons.person)),
            CardSettingsHeader(label: ''),
            CardSettingsButton(
              label: 'DEACTIVATE ACCOUNT',
              isDestructive: true,
              onPressed: () {
                widget.authenticationStore.signOut();
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
            CardSettingsButton(
              label: 'LOG OUT',
              isDestructive: true,
              onPressed: () {
                widget.authenticationStore.signOut();
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
            CardSettingsHeader(label: 'History'),
            CardSettingsButton(
              label: 'CLEAR VIEW HISTORY',
              isDestructive: true,
              onPressed: () {
                widget.viewsStore.clearViews();
              },
            ),
            CardSettingsButton(
              label: 'CLEAR FAVORTIES',
              isDestructive: true,
              onPressed: () {
                _favoritesStore.clearFavorites();
              },
            ),
            CardSettingsHeader(label: ''),
            CSButton(
              CSButtonType.DEFAULT,
              'Contact Us',
              () {},
            ),
            CSButton(CSButtonType.DEFAULT, 'Privacy Policy', () {}),
            CSButton(CSButtonType.DEFAULT, 'Terms of Service', () {}),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
