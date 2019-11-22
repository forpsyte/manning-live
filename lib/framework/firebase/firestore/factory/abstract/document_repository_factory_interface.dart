import 'package:manning_live/framework/firebase/firestore/repository/abstract/document_repository_interface.dart';

abstract class DocumentRepositoryFactoryInterface {
  
  DocumentRepositoryInterface create();
}