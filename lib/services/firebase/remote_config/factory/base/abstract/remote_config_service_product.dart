import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:manning_live/services/abstract/service.dart';

abstract class AbstractRemoteConfigServiceProduct implements AbstractService {
  Future<RemoteConfigValue> getConfig(String key);
}