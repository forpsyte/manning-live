import 'package:manning_live/services/abstract/service.dart';

abstract class AbstractAsyncServiceFactory {
  Future<AbstractService> create();
}