import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/framework/api/search_criteria.dart';

abstract class CollectionProcessorInterface {
  /// Applies the filter groups in [searchCriteria] to the [collection].
  List<AbstractObject> process<T extends AbstractObject>(SearchCriteria searchCriteria, List<T> collection);
}