import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_criteria/collection_processor/filter_processor.dart';
import 'package:manning_live/framework/api/search_results.dart';
import 'package:manning_live/framework/api/search_results_builder.dart';
import 'package:manning_live/services/abstract/service.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/document_snapshot_model.dart';

abstract class AbstractRepository extends AbstractService {
  final String collectionName;
  final Firestore firestore;
  final FilterProcessor _filterProcessor = FilterProcessor();
  final SearchResultsBuilder _searchResultsBuilder = SearchResultsBuilder();

  AbstractRepository(this.collectionName, this.firestore);

  Future<void> create(Map<String, dynamic> data, {String documentId}) async {
    try {
      final String path = documentId == null
          ? "$collectionName"
          : "$collectionName/$documentId";
      final DocumentReference docRef = firestore.document(path);
      await firestore.runTransaction((Transaction tx) async {
        DocumentSnapshot documentSnapshot = await tx.get(docRef);
        if (!documentSnapshot.exists) {
          await tx.set(docRef, data);
        }
      });
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<DocumentSnapshotModel> read(String documentId) async {
    try {
      var document =
          await firestore.collection(collectionName).document(documentId).get();
      return DocumentSnapshotModel.fromDocumentSnapshot(document);
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }

  Future<void> update(String documentId, Map<String, dynamic> data) async {
    try {
      final DocumentReference docRef =
          firestore.document("$collectionName/$documentId");
      await firestore.runTransaction((Transaction tx) async {
        DocumentSnapshot documentSnapshot = await tx.get(docRef);
        if (documentSnapshot.exists) {
          await tx.update(docRef, data);
        }
      });
    } catch (error) {
      print(error.messsage);
      rethrow;
    }
  }

  Future<void> delete(String documentId) async {
    try {
      final DocumentReference docRef =
          firestore.document("$collectionName/$documentId");
      await firestore.runTransaction((Transaction tx) async {
        DocumentSnapshot documentSnapshot = await tx.get(docRef);
        if (documentSnapshot.exists) {
          await tx.delete(docRef);
        }
      });
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }

  Future<SearchResults> getList({SearchCriteria searchCriteria}) async {
    try {
      QuerySnapshot query =
          await Firestore.instance.collection(collectionName).getDocuments();
      final List<DocumentSnapshotModel> documents = query.documents.map((doc) {
        return DocumentSnapshotModel.fromDocumentSnapshot(doc);
      }).toList();
      final List<DocumentSnapshotModel> results = searchCriteria == null
          ? documents
          : _filterProcessor.process(searchCriteria, documents);
      final searchResults = _searchResultsBuilder
          .setItems(results)
          .setSearchCriteria(searchCriteria)
          .setTotalCount(results.length)
          .create();
      return searchResults;
    } catch (error) {
      print(error.message);
      rethrow;
    }
  }
}
