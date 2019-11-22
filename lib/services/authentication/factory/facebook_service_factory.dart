import 'package:firebase_auth/firebase_auth.dart';
import 'package:manning_live/services/authentication/factory/abstract/authentication_service_factory.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';
import 'package:manning_live/services/authentication/factory/base/facebook_sign_in_service.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';

class FacebookServiceFactory implements AuthenticationServiceFactory {
  AbstractSignInService create() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirestoreRepositoryService _repository = FirestoreRepositoryService(UserRepositoryFactory());

    return FacebookSignInService(_auth, _repository);
  }
}