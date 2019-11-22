import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/stores/authentication_store.dart';
import 'package:manning_live/widgets/registration_form.dart';
import 'package:manning_live/widgets/login_form.dart';

class RegistrationPage extends StatefulWidget {
  final AuthenticationStore authenticationStore;

  RegistrationPage(this.authenticationStore);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with TickerProviderStateMixin {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _registrationFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Observer(builder: (_) {
        return SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'manning',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'live',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 600.0,
                  padding: EdgeInsets.fromLTRB(48.0, 48.0, 48.0, 48.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            ScaleTransition(
                      child: child,
                      scale: animation,
                    ),
                    child: widget.authenticationStore.willRegister
                        ? RegistrationForm(
                            formKey: _registrationFormKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            authenticationStore: widget.authenticationStore,
                          )
                        : LoginForm(
                            formKey: _loginFormKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            authenticationStore: widget.authenticationStore,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
