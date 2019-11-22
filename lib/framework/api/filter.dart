import 'package:manning_live/framework/api/abstract_object.dart';

class Filter extends AbstractObject {
  static const keyField = 'field';
  static const keyValue = 'value';
  static const keyConditionType = 'condition_type';

  Filter({Map<String, dynamic> data}) : super(data: data);
  
  String getField(){
    return getData(keyField);
  }
  
  dynamic getValue() {
    return getData(keyValue);
  }

  String getConditionType() {
    return getData(keyConditionType);
  }

  Filter setField(String field) {
    return setData(keyField, field);
  }

  Filter setValue(dynamic value) {
    return setData(keyValue, value);
  }
  Filter setConditionType(String conditionType) {
    return setData(keyConditionType, conditionType);
  }
}