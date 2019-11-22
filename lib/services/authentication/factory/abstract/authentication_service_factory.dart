import 'package:manning_live/services/abstract/service/factory.dart';
import 'package:manning_live/services/authentication/factory/base/abstract/abstract_sign_in_service.dart';

abstract class AuthenticationServiceFactory implements AbstractServiceFactory {
  AbstractSignInService create();
}