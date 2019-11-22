import 'package:manning_live/framework/api/filter.dart';

class FilterBuilder {
  Map<String, dynamic> _data = Map<String, dynamic>();

  FilterBuilder setField(String field) {
    _data[Filter.keyField] = field;
    return this;
  }

  FilterBuilder setValue(String value) {
    _data[Filter.keyValue] = value;
    return this;
  }

  FilterBuilder setConditionType(String conditionType) {
    _data[Filter.keyConditionType] = conditionType;
    return this;
  }

  Filter create() {
    Map<String, dynamic> data = Map.from(_data);
    final Filter filter = Filter(data: data);
    _data.clear();
    return filter;
  }

  Map<String, dynamic> get data => _data;
}