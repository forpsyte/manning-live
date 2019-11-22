import 'package:manning_live/framework/api/filter.dart';
import 'package:manning_live/framework/api/search/filter_group.dart';

class FilterGroupBuilder {
  Map<String, dynamic> _data = Map<String, dynamic>();

  FilterGroupBuilder(){
    _data[FilterGroup.keyFilters] = List<Filter>();
  }

  FilterGroupBuilder addFilter(Filter filter) {
    _data[FilterGroup.keyFilters].add(filter);
    return this;
  }

  FilterGroupBuilder setFilters(List<Filter> filters) {
    _data[FilterGroup.keyFilters].clear();
    _data[FilterGroup.keyFilters].addAll(filters);
    return this;
  }

  // Creates a filter group.
  FilterGroup create() {
    final List<Filter> filters = List.from(_data[FilterGroup.keyFilters]);
    final filterGroup = FilterGroup();
    filterGroup.setFilters(filters);
    _data[FilterGroup.keyFilters].clear();
    return filterGroup;
  }

}