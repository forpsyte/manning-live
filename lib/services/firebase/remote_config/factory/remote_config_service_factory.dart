import 'package:manning_live/services/abstract/service/factory.dart';
import 'package:manning_live/services/firebase/remote_config/factory/base/remote_config_service_product.dart';

class RemoteConfigServiceFactory implements AbstractServiceFactory {
  RemoteConfigServiceProduct create() {
    return RemoteConfigServiceProduct();
  }
}