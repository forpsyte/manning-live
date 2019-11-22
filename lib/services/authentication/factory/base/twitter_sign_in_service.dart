import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/base/sign_in_service_credentials.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';


class TwitterSignInService implements AbstractSignInService {
  final FirebaseAuth _auth;
  final FirestoreRepositoryService _userRepository;

  TwitterSignInService(this._auth, this._userRepository);

  Future<FirebaseUser> signIn({SignInServiceCredentials credentials}) async {
    try {
      var token = await _loginToTwitter();
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

  Future<FirebaseUser> getCurrentUser() async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      return user != null ? user : null;
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<void> saveUser(String uid, String email) async {
    final Map<String, dynamic> data = {
      'email': email,
      'created_at': Timestamp.fromMicrosecondsSinceEpoch(
          DateTime.now().microsecondsSinceEpoch),
      'is_active': true,
      'favorites': [],
      'views': []
    };

    return await _userRepository.create(data, documentId: uid);
  }

  Future<dynamic> _loginToTwitter() async {
    final twitterLogin = new TwitterLogin(
      consumerKey: '<your consumer key>',
      consumerSecret: '<your consumer secret>',
    );
    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        return result.session.token;
      case TwitterLoginStatus.cancelledByUser:
        return false;
      case TwitterLoginStatus.error:
        return false;
    }
  }
}
