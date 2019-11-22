import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search_criteria.dart';
import 'package:manning_live/framework/api/search_criteria/collection_processor_interface.dart';

class FilterProcessor implements CollectionProcessorInterface {
  /// Applies the filter groups in [searchCriteria] to the [collection].
  List<AbstractObject> process<T extends AbstractObject>(
      SearchCriteria searchCriteria, List<T> collection) {
    List<T> list = List<T>();
    List<T> workingCollection = List<T>();
    searchCriteria.getFilterGroups().forEach((filterGroup) {
      workingCollection =
          list.isEmpty ? List.from(collection) : List.from(list);
      list.clear();
      filterGroup.getFilters().forEach((filter) {
        Function operate = getOperator(filter.getConditionType());
        var result = workingCollection
            .where((item) =>
                operate(item.getData(filter.getField()), filter.getValue()))
            .toList();
        list.addAll(result);
      });
      workingCollection = List.from(list);
    });
    return workingCollection;
  }

  Function getOperator(String key) {
    Map<String, Function> operators = {
      "eq": (a, b) => a == b,
      "ne": (a, b) => a != b,
      "gt": (a, b) => a > b,
      "lt": (a, b) => a < b,
    };

    return operators[key];
  }
}
