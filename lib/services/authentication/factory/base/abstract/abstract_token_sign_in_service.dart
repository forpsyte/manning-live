import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractTokenSignInService {
  Future<FirebaseUser> signIn();
  Future<FirebaseUser> loginOnStartup();
  Future<void> signOut();
}