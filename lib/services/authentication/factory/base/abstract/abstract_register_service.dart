import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractRegisterService {
  Future<FirebaseUser> register(String email, String password);
}