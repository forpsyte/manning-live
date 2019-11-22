import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:manning_live/stores/authentication_store.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required this.authenticationStore,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final AuthenticationStore authenticationStore;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              'SIGN UP',
              style: Theme.of(context).primaryTextTheme.display1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _emailController,
              showCursor: true,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            showCursor: true,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: Colors.black,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: OutlineButton(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(32.0),
              ),
              onPressed: () async {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  final authenticated =
                      await authenticationStore.register(
                          _emailController.text, _passwordController.text);
                  if (authenticated) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                }
              },
              child: Center(
                child: Container(
                  height: 60.0,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text("or sign up with"),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButton(
                  Buttons.Google,
                  mini: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(32.0),
                  ),
                  onPressed: () async {
                    final bool authenticated =
                        await authenticationStore.signIn('google');
                    if (authenticated) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
                SignInButton(
                  Buttons.Facebook,
                  mini: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(32.0),
                  ),
                  onPressed: () async {
                    final bool authenticated =
                        await authenticationStore.signIn('facebook');
                    if (authenticated) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
                SignInButton(
                  Buttons.Twitter,
                  mini: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(32.0),
                  ),
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.GitHub,
                  mini: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(32.0),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Already have an account?'),
                Container(
                  width: 55.0,
                  height: 20.0,
                  child: Center(
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        authenticationStore.toggleForm();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}