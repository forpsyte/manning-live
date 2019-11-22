import 'package:firebase_auth/firebase_auth.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_register_service.dart';
import 'package:manning_live/services/authentication/factory/base/sign_in_service_credentials.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';

class EmailSignInService extends AbstractSignInService implements AbstractRegisterService {
  final FirebaseAuth _auth;
  final FirestoreRepositoryService _userRepository;

  EmailSignInService(this._auth, this._userRepository) : super(_auth, _userRepository);


  Future<FirebaseUser> signIn({SignInServiceCredentials credentials}) async {
    assert(credentials.getCredential('email') != null);
    assert(credentials.getCredential('password') != null);
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: credentials.getCredential('email'),
        password: credentials.getCredential('password'),
      ))
          .user;
      assert(user != null);

      return user;
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }

  Future<FirebaseUser> register(String email, String password) async {
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      assert(user != null);
      saveUser(user.uid, user.email);
      return user;
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }
}
