import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/services/abstract/service.dart';
import 'package:manning_live/services/authentication/factory/base/sign_in_service_credentials.dart';
import 'package:manning_live/services/firebase/firestore/repository/firestore.dart';

abstract class AbstractSignInService implements AbstractService{
  final FirebaseAuth _auth;
  final FirestoreRepositoryService _userRepository;

  AbstractSignInService(this._auth, this._userRepository);

  Future<FirebaseUser> signIn({SignInServiceCredentials credentials});

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
}