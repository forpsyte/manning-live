import 'package:manning_live/framework/services/abstract/service.dart';

abstract class AbstractAsyncServiceFactory {
  Future<AbstractService> create();
}