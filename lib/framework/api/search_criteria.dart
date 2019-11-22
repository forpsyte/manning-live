import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search/filter_group.dart';
import 'package:manning_live/framework/api/search_criteria_interface.dart';

class SearchCriteria extends AbstractObject implements SearchCriteriaInterface {
  static const keyFilterGroups = 'filter_groups';
  SearchCriteria({Map<String, dynamic> data}) : super(data: data);
  
  List<FilterGroup> getFilterGroups() {
    return getListData<FilterGroup>(keyFilterGroups);
  }

  SearchCriteria setFilterGroups(List<FilterGroup> filterGroup) {
    return setData(keyFilterGroups, filterGroup);
  }
}

