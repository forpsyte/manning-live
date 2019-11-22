import 'package:async/async.dart';
import 'package:manning_live/framework/api/abstract_object.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/firebase/firestore/repository/firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:manning_live/services/system/preferences_service.dart';
part 'stories_store.g.dart';

class StoriesStore = StoriesStoreBase with _$StoriesStore;

abstract class StoriesStoreBase with Store {
  final FirestoreRepositoryService _postService;
  final PreferencesService _preferencesService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  int headLinesCnt = 4;
  int _currentPage = 1;
  bool _isLoadingNextPage = false;

  @observable
  bool hasNextPage = false;

  @observable
  ObservableList<PostModel> collection = ObservableList<PostModel>();

  @observable
  ObservableFuture loadCollectionItemsFuture;

  @observable
  bool loadingNextPage = false;

  @observable
  PostModel currentStory;

  List<PostModel> get headlines => collection.take(headLinesCnt).toList();

  @computed
  List<PostModel> get stories => collection.skip(headLinesCnt).toList();

  StoriesStoreBase(this._postService, this._preferencesService);

  @action
  void setCurrentStory(PostModel story) {
    currentStory = story;
  }

  @action
  void clearCurrentStory() {
    currentStory = null;
  }
  
  @action
  Future<void> refresh() {
    return _loadInitialStories();
  }
  
  @action
  void retry() {
    loadCollectionItemsFuture = ObservableFuture(_loadInitialStories());
  }

  @action
  void loadInitialStories() {
    loadCollectionItemsFuture = ObservableFuture(_asyncMemoizer.runOnce(() async {
      await _loadInitialStories();
    }));
  }

  @action
  Future<void> loadNextPage() async {
    try {
      if (_isLoadingNextPage || (_currentPage > 1 && !hasNextPage)) {
        return;
      }
      _isLoadingNextPage = true;
      var results = await _postService.getList();
      List<PostModel> collectionItems = results.getItems();
      collection.addAll(collectionItems);
      _currentPage++;
      hasNextPage = false;
      
    } finally {
      _isLoadingNextPage = false;
    }
  }

  @action
  Future<void> _loadFirstPageStories() async {
    collection.clear();
    _currentPage = 1;
    await loadNextPage();
  }

  @action
  Future<void> _loadInitialStories() async {
    collection.clear();
    _currentPage = 1;
    var results = await _postService.getList();
    var collectionItems = results.getItems<PostModel>();
    collection.addAll(collectionItems);
  }
}