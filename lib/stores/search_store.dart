import 'package:manning_live/services/algolia/algolia_service.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/system/preferences_service.dart';
import 'package:mobx/mobx.dart';
part 'search_store.g.dart';

class SearchStore = SearchStoreBase with _$SearchStore;

abstract class SearchStoreBase with Store {
  final AlgoliaService algoliaService;
  final PreferencesService preferencesService;

  @observable
  String previousQuery;

  @observable
  bool searchExecuted = false;

  @observable
  ObservableList<String> searchHistory = ObservableList<String>();

  @observable
  ObservableList<PostModel> results = ObservableList<PostModel>();

  @observable
  ObservableFuture loadresultItemsFuture;

  SearchStoreBase(this.algoliaService, this.preferencesService);

  @action
  void search(String query) {
    loadresultItemsFuture = ObservableFuture(_executeSearch(query));
  }

  @action
  void _addSearchTerm(String searchTerm) {
    if(!searchHistory.contains(searchTerm)) {
      searchHistory.insert(0,searchTerm);
      _saveSearchHistory();
    } else {
      searchHistory.removeWhere((term) => term == searchTerm);
      searchHistory.insert(0,searchTerm);
      _saveSearchHistory();
    }
  }

  @action 
  void loadSearchHistory() {
    searchHistory.addAll(preferencesService.searchHistory);
  }

  @action
  void clearSearchHistory() {
    searchHistory.clear();
    _saveSearchHistory();
  }

  @action
  void clearSearchResults() {
    results.clear();
    searchExecuted = false;
  }

  @action
  Future<void> _executeSearch(String query) async {
    results.clear();
    var hits = await algoliaService.search(query);
    var storyComponents = hits.map((hit) => PostModel.fromAlgoliaQuerySnapshot(hit)).toList();
    results.addAll(storyComponents);
    searchExecuted = true;
    previousQuery = query;
    _addSearchTerm(query);
  }

  void _saveSearchHistory() {
    preferencesService.searchHistory.clear();
    preferencesService.searchHistory = searchHistory;
  }

}
