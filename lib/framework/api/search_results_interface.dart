import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search_criteria.dart';

abstract class SearchResultsInterface {
  List<T> getItems<T extends AbstractObject>();
  SearchResultsInterface setItems(List<AbstractObject> items);
  SearchCriteria getSearchCriteria();
  SearchResultsInterface setSearchCriteria(SearchCriteria searchCriteria);
  int getTotalCount();
  SearchResultsInterface setTotalCount(int count);
}