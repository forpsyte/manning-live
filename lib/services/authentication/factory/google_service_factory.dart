import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/abstract/authentication_service_factory.dart';
import 'package:manning_live/services/authentication/factory/base/google_sign_in_service.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';

class GoogleServiceFactory implements AuthenticationServiceFactory {
  AbstractSignInService create() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirestoreRepositoryService _repository = FirestoreRepositoryService(UserRepositoryFactory());

    return GoogleSignInService(_auth, _googleSignIn, _repository);
  }
}