import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_results.dart';

class SearchResultsBuilder {
  static const keySearchResults = 'search_results';
  Map<String, dynamic> _data = Map<String, dynamic>();

  SearchResultsBuilder setItems(List<AbstractObject> items) {
    if (items == null) {
      _data[SearchResults.keyItems] = [];
    } else {
      _data[SearchResults.keyItems] = List.from(items);
    }
    
    return this;
  }

  SearchResultsBuilder setSearchCriteria(SearchCriteria searchCriteria) {
    _data[SearchResults.keySearchCriteria] = searchCriteria;
    return this;
  }

  SearchResultsBuilder setTotalCount(int count) {
    _data[SearchResults.keyTotalCount] = count;
    return this;
  }

  SearchResults create() {
    Map<String, dynamic> data = Map.from(_data);
    _data.clear();
    return SearchResults(data: data);
  }
}