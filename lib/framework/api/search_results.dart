import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_results_interface.dart';

class SearchResults extends AbstractObject implements SearchResultsInterface {
  static const keyItems = 'items';
  static const keySearchCriteria = 'search_criteria';
  static const keyTotalCount = 'total_count';
  
  SearchResults({Map<String, dynamic> data}) : super(data: data);

  List<T> getItems<T extends AbstractObject>(){
    Map<String, dynamic> data = getMappedData();
    List<T> items = List.from(data[keyItems]);
    return items;
  }

  SearchResultsInterface setItems(List<AbstractObject> items){
    setData(keyItems, List.from(items));
    return this;
  }

  SearchCriteria getSearchCriteria(){
    Map<String, dynamic> data = getMappedData();
    return data[keySearchCriteria];
  }

  SearchResultsInterface setSearchCriteria(SearchCriteria searchCriteria){
    setData(keySearchCriteria, searchCriteria);
    return this;
  }

  int getTotalCount(){
    Map<String, dynamic> data = getMappedData();
    return data[keyTotalCount];
  }

  SearchResultsInterface setTotalCount(int count){
    setData(keyTotalCount, count);
    return this;
  }
}

