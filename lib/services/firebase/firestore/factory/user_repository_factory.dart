import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/services/firebase/firestore/factory/base/user.dart';
import 'package:manning_live/services/firebase/firestore/factory/abstract/firestore_repository_factory.dart';

class UserRepositoryFactory implements FirestoreRepositoryFactory {
  UserRepository create() {
    final String collectionName = 'users';
    final Firestore firestore = Firestore.instance;

    return UserRepository(collectionName, firestore);
  }
}