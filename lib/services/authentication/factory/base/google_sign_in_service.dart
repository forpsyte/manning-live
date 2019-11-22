import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/base/sign_in_service_credentials.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';

class GoogleSignInService extends AbstractSignInService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirestoreRepositoryService _userRepository;

  GoogleSignInService(this._auth, this._googleSignIn, this._userRepository) : super(_auth, _userRepository);

  Future<FirebaseUser> signIn({SignInServiceCredentials credentials}) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
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

      return user;
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
