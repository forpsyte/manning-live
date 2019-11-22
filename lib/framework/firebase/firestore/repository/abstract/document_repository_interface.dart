import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_results.dart';

abstract class DocumentRepositoryInterface {

  Future<void> create(Map<String, dynamic> data, {String documentId});

  Future<AbstractObject> read(String documentId);

  Future<void> update(String documentId, Map<String, dynamic> data);

  Future<void> delete(String documentId);

  Future<SearchResults> getList({SearchCriteria searchCriteria});
}