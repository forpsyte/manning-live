import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_results.dart';
import 'package:manning_live/services/abstract/service/factory.dart';
import 'package:manning_live/services/firebase/firestore/factory/base/abstract/repository.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/document_snapshot_model.dart';

class FirestoreRepositoryService<T extends AbstractServiceFactory>{
  final T _factory;
  AbstractRepository _repository;

  FirestoreRepositoryService(this._factory) {
    _repository = _factory.create();
  }

  Future<void> create(Map<String, dynamic> data, {String documentId}) async {
    return await _repository.create(data, documentId: documentId);
  }

  Future<DocumentSnapshotModel> read(String documentId) async {
    return await _repository.read(documentId);
  }

  Future<void> update(String documentId, Map<String, dynamic> data) async {
    return await _repository.update(documentId, data);
  }

  Future<void> delete(String documentId) async {
    return await _repository.delete(documentId);
  }

  Future<SearchResults> getList({SearchCriteria searchCriteria}) async {
    return await _repository.getList(searchCriteria: searchCriteria);
  }
}