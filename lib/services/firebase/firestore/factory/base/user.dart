import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/services/firebase/firestore/factory/base/abstract/repository.dart';

class UserRepository extends AbstractRepository {
  final String collectionName;
  final Firestore firestore;

  UserRepository(this.collectionName,this.firestore) : super(collectionName, firestore);
}