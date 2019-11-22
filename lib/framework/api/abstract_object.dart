abstract class AbstractObject {

  AbstractObject({Map<String, dynamic> data}) {
    if (data != null) {
      _data = Map.from(data);
    } 
  }
  
  Map<String, dynamic> _data = Map<String, dynamic>();

  dynamic getData(String key) {
    return _data.containsKey(key) ? _data[key] : null;
  }

  Map<String, dynamic> getMappedData() {
    return _data;
  }

  List<T> getListData<T>(String key) {
    List<T> data = _data.containsKey(key) ? _data[key].cast<T>() : null;
    return data;
  }

  AbstractObject setData(key, value) {
    _data[key] = value;
    return this;
  }
}