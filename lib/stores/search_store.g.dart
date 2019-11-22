// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$SearchStore on SearchStoreBase, Store {
  final _$previousQueryAtom = Atom(name: 'SearchStoreBase.previousQuery');

  @override
  String get previousQuery {
    _$previousQueryAtom.context.enforceReadPolicy(_$previousQueryAtom);
    _$previousQueryAtom.reportObserved();
    return super.previousQuery;
  }

  @override
  set previousQuery(String value) {
    _$previousQueryAtom.context.conditionallyRunInAction(() {
      super.previousQuery = value;
      _$previousQueryAtom.reportChanged();
    }, _$previousQueryAtom, name: '${_$previousQueryAtom.name}_set');
  }

  final _$searchExecutedAtom = Atom(name: 'SearchStoreBase.searchExecuted');

  @override
  bool get searchExecuted {
    _$searchExecutedAtom.context.enforceReadPolicy(_$searchExecutedAtom);
    _$searchExecutedAtom.reportObserved();
    return super.searchExecuted;
  }

  @override
  set searchExecuted(bool value) {
    _$searchExecutedAtom.context.conditionallyRunInAction(() {
      super.searchExecuted = value;
      _$searchExecutedAtom.reportChanged();
    }, _$searchExecutedAtom, name: '${_$searchExecutedAtom.name}_set');
  }

  final _$searchHistoryAtom = Atom(name: 'SearchStoreBase.searchHistory');

  @override
  ObservableList<String> get searchHistory {
    _$searchHistoryAtom.context.enforceReadPolicy(_$searchHistoryAtom);
    _$searchHistoryAtom.reportObserved();
    return super.searchHistory;
  }

  @override
  set searchHistory(ObservableList<String> value) {
    _$searchHistoryAtom.context.conditionallyRunInAction(() {
      super.searchHistory = value;
      _$searchHistoryAtom.reportChanged();
    }, _$searchHistoryAtom, name: '${_$searchHistoryAtom.name}_set');
  }

  final _$resultsAtom = Atom(name: 'SearchStoreBase.results');

  @override
  ObservableList<PostModel> get results {
    _$resultsAtom.context.enforceReadPolicy(_$resultsAtom);
    _$resultsAtom.reportObserved();
    return super.results;
  }

  @override
  set results(ObservableList<PostModel> value) {
    _$resultsAtom.context.conditionallyRunInAction(() {
      super.results = value;
      _$resultsAtom.reportChanged();
    }, _$resultsAtom, name: '${_$resultsAtom.name}_set');
  }

  final _$loadresultItemsFutureAtom =
      Atom(name: 'SearchStoreBase.loadresultItemsFuture');

  @override
  ObservableFuture get loadresultItemsFuture {
    _$loadresultItemsFutureAtom.context
        .enforceReadPolicy(_$loadresultItemsFutureAtom);
    _$loadresultItemsFutureAtom.reportObserved();
    return super.loadresultItemsFuture;
  }

  @override
  set loadresultItemsFuture(ObservableFuture value) {
    _$loadresultItemsFutureAtom.context.conditionallyRunInAction(() {
      super.loadresultItemsFuture = value;
      _$loadresultItemsFutureAtom.reportChanged();
    }, _$loadresultItemsFutureAtom,
        name: '${_$loadresultItemsFutureAtom.name}_set');
  }

  final _$_executeSearchAsyncAction = AsyncAction('_executeSearch');

  @override
  Future<void> _executeSearch(String query) {
    return _$_executeSearchAsyncAction.run(() => super._executeSearch(query));
  }

  final _$SearchStoreBaseActionController =
      ActionController(name: 'SearchStoreBase');

  @override
  void search(String query) {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction();
    try {
      return super.search(query);
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _addSearchTerm(String searchTerm) {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction();
    try {
      return super._addSearchTerm(searchTerm);
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadSearchHistory() {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction();
    try {
      return super.loadSearchHistory();
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchHistory() {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction();
    try {
      return super.clearSearchHistory();
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchResults() {
    final _$actionInfo = _$SearchStoreBaseActionController.startAction();
    try {
      return super.clearSearchResults();
    } finally {
      _$SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
