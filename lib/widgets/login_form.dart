import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/stores/authentication_store.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
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
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Form(
        key: widget._formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                'SIGN IN',
                style: Theme.of(context).primaryTextTheme.display1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: widget._emailController,
                showCursor: true,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
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
              controller: widget._passwordController,
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
                  if (widget._formKey.currentState.validate()) {
                    final authenticated = await widget.authenticationStore
                        .signIn(
                            'email',
                            email: widget._emailController.text,
                            password: widget._passwordController.text);
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
            Container(
              child: widget.authenticationStore.errorMessage != null
                  ? Text(
                      widget.authenticationStore.errorMessage,
                      style: Theme.of(context).primaryTextTheme.caption,
                      textAlign: TextAlign.center,
                    )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Don\'t have an account?'),
                  Container(
                    width: 75.0,
                    height: 20.0,
                    child: Center(
                      child: FlatButton(
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          widget.authenticationStore.toggleForm();
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
    });
  }
}
