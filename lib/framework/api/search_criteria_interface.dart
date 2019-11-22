import 'package:manning_live/framework/api/search/filter_group.dart';

abstract class SearchCriteriaInterface {
  List<FilterGroup>  getFilterGroups();
  SearchCriteriaInterface setFilterGroups(List<FilterGroup> filterGroup);
}