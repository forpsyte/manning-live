import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/framework/firebase/firestore/factory/abstract/document_repository_factory_interface.dart';
import 'package:manning_live/framework/firebase/firestore/repository/document_repository.dart';

class DocumentRepositoryFactory implements DocumentRepositoryFactoryInterface {
  
  final String collectionName;
  final Firestore firestore = Firestore.instance;

  DocumentRepositoryFactory(this.collectionName);

  DocumentRepository create() {
    return DocumentRepository(collectionName, firestore);
  }
}