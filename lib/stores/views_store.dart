import 'package:manning_live/services/firebase/firestore/firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:manning_live/services/system/preferences_service.dart';
part 'views_store.g.dart';

class ViewsStore = ViewsStoreBase with _$ViewsStore;

abstract class ViewsStoreBase with Store {
  final PreferencesService _preferencesService;
  final FirestoreRepositoryService _postService;

  ViewsStoreBase(this._preferencesService, this._postService);

  @observable
  ObservableList<String> views = ObservableList<String>();

  @computed
  bool get hasViews => views.isNotEmpty;

  bool isInViews(String documentId) =>
    views.any((view) => view == documentId);

  @action
  void loadViews() {
    _preferencesService.views
      .forEach((view) => views.add(view));
  }

  @action
  Future<void> addView(String documentId) async {
    if(!views.contains(documentId)) {
      views.add(documentId);
      DocumentSnapshotModel document = await _postService.read(documentId);
      int numViews = document.getData('num_views');
      await _postService.update(documentId, {'num_views': numViews + 1});
      _saveViews();
    }
  }

  @action clearViews() {
    views.clear();
    _saveViews();
  }

  void _saveViews() {
    _preferencesService.views.clear();
    _preferencesService.views = views.toList();
  }
  
}