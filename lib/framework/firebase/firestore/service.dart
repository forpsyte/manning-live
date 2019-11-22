import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_results.dart';
import 'package:manning_live/framework/firebase/firestore/factory/abstract/document_repository_factory_interface.dart';
import 'package:manning_live/framework/firebase/firestore/model/document_model.dart';
import 'package:manning_live/framework/firebase/firestore/repository/abstract/document_repository_interface.dart';

class FirestoreService<T extends DocumentRepositoryFactoryInterface> {
  final T _factory;
  DocumentRepositoryInterface _repository;

  FirestoreService(this._factory) {
    _repository = _factory.create();
  }

  Future<void> create(Map<String, dynamic> data, {String documentId}) async {
    return await _repository.create(data, documentId: documentId);
  }

  Future<DocumentModel> read(String documentId) async {
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