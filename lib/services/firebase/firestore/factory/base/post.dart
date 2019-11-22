import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_criteria/collection_processor/filter_processor.dart';
import 'package:manning_live/framework/api/search_results.dart';
import 'package:manning_live/framework/api/search_results_builder.dart';
import 'package:manning_live/services/firebase/firestore/factory/base/abstract/repository.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';

class PostRepository extends AbstractRepository {
  final String collectionName;
  final Firestore firestore;
  final FilterProcessor _filterProcessor = FilterProcessor();
  final SearchResultsBuilder _searchResultsBuilder = SearchResultsBuilder();

  PostRepository(this.collectionName, this.firestore)
      : super(collectionName, firestore);

  Future<SearchResults> getList({SearchCriteria searchCriteria}) async {
    try {
      QuerySnapshot query = await Firestore.instance
          .collection(collectionName)
          .orderBy('published_at', descending: true)
          .getDocuments();
      final List<PostModel> documents = query.documents.map((doc) {
        return PostModel.fromDocumentSnapshot(doc);
      }).toList();
      final List<PostModel> results = searchCriteria == null
          ? documents
          : _filterProcessor.process(searchCriteria, documents);
      final searchResults = _searchResultsBuilder
          .setItems(results)
          .setSearchCriteria(searchCriteria)
          .setTotalCount(results.length)
          .create();
      return searchResults;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
