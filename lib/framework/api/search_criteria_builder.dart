import 'package:manning_live/framework/api/filter.dart';
import 'package:manning_live/framework/api/filter_builder.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search/filter_group.dart';
import 'package:manning_live/framework/api/search/filter_group_builder.dart';

class SearchCriteriaBuilder {
  Map<String, dynamic> _data = Map<String, dynamic>();
  FilterBuilder _filterBuilder;
  FilterGroupBuilder _filterGroupBuilder;

  SearchCriteriaBuilder() {
    _filterBuilder = FilterBuilder();
    _filterGroupBuilder = FilterGroupBuilder();
    _data[SearchCriteria.keyFilterGroups] = List<FilterGroup>();
  }

  SearchCriteriaBuilder addFilters(List<Filter> filters) {
    final filterGroup = _filterGroupBuilder.setFilters(filters).create();
    _data[SearchCriteria.keyFilterGroups].add(filterGroup);
    
    return this;
  }

  SearchCriteriaBuilder addFilter(String field, dynamic value,
      {String conditionType = 'eq'}) {
    
    return addFilters([
      _filterBuilder
          .setField(field)
          .setValue(value)
          .setConditionType(conditionType)
          .create()
    ]);
  }

  SearchCriteriaBuilder setFilterGroups(List<FilterGroup> filterGroups) {
    _data[SearchCriteria.keyFilterGroups].clear();
    _data[SearchCriteria.keyFilterGroups].addAll(filterGroups);
    
    return this;
  }

  SearchCriteria create() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data.addAll(_data);
     _data[SearchCriteria.keyFilterGroups].clear();
    return SearchCriteria(data: data);
  }
}
