import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/filter.dart';

class FilterGroup extends AbstractObject {
  static const keyFilters = 'filters';

  List<Filter> getFilters() {
    return getListData<Filter>(keyFilters);
  }

  FilterGroup setFilters(List<Filter> filters) {
    return setData(keyFilters, List.from(filters));
  }
}