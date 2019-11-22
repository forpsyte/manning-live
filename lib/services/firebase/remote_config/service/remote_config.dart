
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:manning_live/services/abstract/service/factory.dart';
import 'package:manning_live/services/firebase/remote_config/factory/base/abstract/remote_config_service_product.dart';

class RemoteConfigService<T extends AbstractServiceFactory> {
  final T _factory;
  AbstractRemoteConfigServiceProduct _service;
  RemoteConfigValue _config;
  
  RemoteConfigService(this._factory) {
    _service = _factory.create();
  }
  
  Future<RemoteConfigService> getConfig(String key) async { 
    _config = await _service.getConfig(key);
    return this;
  }

  String asString() {
    return _config == null ? null : _config.asString();
  }

  int asInt() {
    return _config == null ? null : _config.asInt();
  }

  bool asBool() {
    return _config == null ? null : _config.asBool();
  }

  double asDouble() {
    return _config == null ? null : _config.asDouble();
  }
}