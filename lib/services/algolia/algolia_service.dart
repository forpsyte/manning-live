import 'package:manning_live/services/abstract/service.dart';
import 'package:algolia/algolia.dart';

class AlgoliaService implements AbstractService {
  static final String index = "dev_MANNINGLIVE_POST"; 
  static final String applicationId = "DYQDKDMU6X";
  static final String apiKey = "80c824dc7926138c1eb9aec7cdcd4f04";
  static final Algolia algolia = Algolia.init(
    applicationId: applicationId, 
    apiKey: apiKey
  );

  Future<List<Map<String, dynamic>>> search(String queryString) async {
    var results = List<Map<String, dynamic>>();
    var query = algolia.instance.index(index).search(queryString);
    var snapshot = await query.getObjects();
    var hits = snapshot.hits;
    for (var hit in hits) {
      var _hit = hit;
      _hit.data["objectID"] = hit.objectID;
      results.add(_hit.data);
    }
    return results;
  }

  Future<List<Map<String, dynamic>>> searchAll(List<String> queryStrings) async {
    var results = List<Map<String, dynamic>>();
    for(var query in queryStrings) {
      List<Map<String, dynamic>> hits = await search(query);
      results.addAll(hits);
    }
    return results;
  }
}