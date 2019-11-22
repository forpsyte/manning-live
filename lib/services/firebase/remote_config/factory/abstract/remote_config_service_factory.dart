import 'package:manning_live/services/firebase/remote_config/factory/base/abstract/remote_config_service_product.dart';

abstract class AbstractRemoteConfigServiceFactory {
  AbstractRemoteConfigServiceProduct create();
}