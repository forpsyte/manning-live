import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:manning_live/stores/authentication_store.dart';
import 'package:manning_live/widgets/home.dart';
import 'package:manning_live/screens/registration_page.dart';

class LoadingPage extends StatefulWidget {
  final AuthenticationStore store;
  LoadingPage(this.store);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    widget.store.initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        switch (widget.store.loadUserFuture.status) {
          case FutureStatus.rejected:
            return RegistrationPage(widget.store);
          case FutureStatus.fulfilled:
            if (widget.store.isLoggedIn) {
              return HomePage();
            }
            return RegistrationPage(widget.store);
          case FutureStatus.pending:
            return _buildProgressIndicator();
          default:
            return _buildProgressIndicator();
        }
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
