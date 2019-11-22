import 'package:firebase_auth/firebase_auth.dart';
import 'package:manning_live/services/authentication/authentication.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/base/sign_in_service_credentials.dart';
import 'package:manning_live/services/authentication/factory/email_service_factory.dart';

class AuthenticationService {
  static const EMAIL = 'email';
  static const FACEBOOK = 'facebook';
  static const GOOGLE = 'google';
  static const TWITTER = 'twitter';
  static const GITHUB = 'github';

  final Map<String, Function> factories = {
    'email': () => EmailServiceFactory(),
    'google': () => GoogleServiceFactory(),
    'facebook': () => FacebookServiceFactory(),
  };

  AbstractSignInService _signInService;

  Future<FirebaseUser> signIn({SignInServiceCredentials credentials}) async {
    return await _signInService.signIn(credentials: credentials);
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _signInService.getCurrentUser();
  }

  Future<void> signOut() async {
    await _signInService.signOut();
  }

  Future<FirebaseUser> register(String email, String password) async {
    return await factories[AuthenticationService.EMAIL]()
        .create()
        .register(email, password);
  }

  void createFactory(String key) {
    _signInService =
        factories.containsKey(key) ? factories[key]().create() : null;
  }
}
