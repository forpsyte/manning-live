import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/base/sign_in_service_credentials.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';

class FacebookSignInService extends AbstractSignInService {
  final FirebaseAuth _auth;
  final FirestoreRepositoryService _userRepository;

  FacebookSignInService(this._auth, this._userRepository) : super(_auth, _userRepository);

  Future<FirebaseUser> signIn({SignInServiceCredentials credentials}) async {
    try {
      var token = await _loginToFacebook();
      if(token == false) {
        throw('Unable to login using Facebook');
      }
      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: token,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      final firestoreUserRecord = await _userRepository.read(user.uid);

      if (!firestoreUserRecord.exists) {
        saveUser(user.uid, user.email);
      }
      return currentUser;
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }

  Future<dynamic> _loginToFacebook() async {
    final facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return result.accessToken.token;
      case FacebookLoginStatus.cancelledByUser:
        return false;
      case FacebookLoginStatus.error:
        return false;
    } 
  }
}
