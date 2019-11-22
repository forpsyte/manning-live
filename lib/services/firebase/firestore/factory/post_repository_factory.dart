import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/services/firebase/firestore/factory/abstract/firestore_repository_factory.dart';
import 'package:manning_live/services/firebase/firestore/factory/base/post.dart';

class PostRepositoryFactory implements FirestoreRepositoryFactory {
  PostRepository create() {
    final String collectionName = 'wp_posts';
    final Firestore firestore = Firestore.instance;

    return PostRepository(collectionName, firestore);
  }
}