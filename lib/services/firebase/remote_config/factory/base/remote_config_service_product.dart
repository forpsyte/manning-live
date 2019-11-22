import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:manning_live/services/firebase/remote_config/factory/base/abstract/remote_config_service_product.dart';

class RemoteConfigServiceProduct implements AbstractRemoteConfigServiceProduct {
  Future<RemoteConfigValue> getConfig(String key) async {
    final RemoteConfig _remoteConfig = await RemoteConfig.instance;
    final Map<String,dynamic> defaults = {key: ''};
    await _remoteConfig.setDefaults(defaults);
    await _remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await _remoteConfig.activateFetched();
    return _remoteConfig.getValue(key);
  }
}