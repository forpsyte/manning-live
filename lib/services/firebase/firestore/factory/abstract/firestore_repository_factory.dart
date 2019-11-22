import 'package:manning_live/services/abstract/service/factory.dart';
import 'package:manning_live/services/firebase/firestore/factory/base/abstract/repository.dart';

abstract class FirestoreRepositoryFactory implements AbstractServiceFactory {
  AbstractRepository create();
}