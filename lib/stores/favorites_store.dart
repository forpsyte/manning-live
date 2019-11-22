import 'package:async/async.dart';
import 'package:mobx/mobx.dart';
import 'package:manning_live/framework/api/filter_builder.dart';
import 'package:manning_live/framework/api/search/filter_group_builder.dart';
import 'package:manning_live/framework/api/search_criteria_builder.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/document_snapshot_model.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/firebase/firestore/firestore.dart';
import 'package:manning_live/services/system/preferences_service.dart';
part 'favorites_store.g.dart';

class FavoritesStore = FavoritesStoreBase with _$FavoritesStore;

abstract class FavoritesStoreBase with Store {
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  final FilterBuilder _filterBuilder = FilterBuilder();
  final FilterGroupBuilder _filterGroupBuilder = FilterGroupBuilder();
  final SearchCriteriaBuilder _searchCriteriaBuilder = SearchCriteriaBuilder();
  final FirestoreRepositoryService _postService; 
  final PreferencesService _preferencesService;

  FavoritesStoreBase(this._preferencesService, this._postService);

  @observable
  ObservableFuture loadFavoritesFuture;

  @observable
  ObservableList<String> favorites = ObservableList<String>();

  @observable 
  ObservableList<dynamic> favoritesAsStoryComponents = ObservableList<dynamic>();


  @computed
  bool get hasFavorites => favorites.isNotEmpty;

  bool isInFavorites(String documentId) =>
      favorites.any((favorite) => favorite == documentId);

  @action
  void retry() {
    loadFavoritesFuture = ObservableFuture(_reloadFavorites());
  }
  
  @action
  void loadFavorites() {
    loadFavoritesFuture = ObservableFuture(_asyncMemoizer.runOnce(() async {
      _reloadFavorites();
    }));
  }

  @action
  addFavorite(DocumentSnapshotModel story) {
    favorites.add(story.getData('document_id'));
    favoritesAsStoryComponents.add(story);
    _saveFavorites();
  }

  @action
  void removeFavorite(String documentId) {
    favorites.removeWhere((favorite) => favorite == documentId);
    favoritesAsStoryComponents.removeWhere((favorite) => favorite.getData('document_id') == documentId);
    _saveFavorites();
  }

  @action
  Future<void> _reloadFavorites() async {
    favorites.clear();
    favoritesAsStoryComponents.clear();
    _preferencesService.favorites.forEach((postId){
      var filter = _filterBuilder.setField('document_id').setValue(postId).setConditionType('eq').create();
      _filterGroupBuilder.addFilter(filter);
    });
    final searchCriteria = _searchCriteriaBuilder.setFilterGroups([_filterGroupBuilder.create()]).create();
    var results = await _postService.getList(searchCriteria: searchCriteria);
    var documents = results.getItems<PostModel>();
    documents.forEach((favorite) => favorites.add(favorite.getData('document_id')));
    favoritesAsStoryComponents.addAll(documents);
  }

  void clearFavorites() {
    favorites.clear();
    _saveFavorites();
  }

  void _saveFavorites() {
    _preferencesService.favorites.clear();
    _preferencesService.favorites = favorites;
  }
}
