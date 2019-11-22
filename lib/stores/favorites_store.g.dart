// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$FavoritesStore on FavoritesStoreBase, Store {
  Computed<bool> _$hasFavoritesComputed;

  @override
  bool get hasFavorites =>
      (_$hasFavoritesComputed ??= Computed<bool>(() => super.hasFavorites))
          .value;

  final _$loadFavoritesFutureAtom =
      Atom(name: 'FavoritesStoreBase.loadFavoritesFuture');

  @override
  ObservableFuture get loadFavoritesFuture {
    _$loadFavoritesFutureAtom.context
        .enforceReadPolicy(_$loadFavoritesFutureAtom);
    _$loadFavoritesFutureAtom.reportObserved();
    return super.loadFavoritesFuture;
  }

  @override
  set loadFavoritesFuture(ObservableFuture value) {
    _$loadFavoritesFutureAtom.context.conditionallyRunInAction(() {
      super.loadFavoritesFuture = value;
      _$loadFavoritesFutureAtom.reportChanged();
    }, _$loadFavoritesFutureAtom,
        name: '${_$loadFavoritesFutureAtom.name}_set');
  }

  final _$favoritesAtom = Atom(name: 'FavoritesStoreBase.favorites');

  @override
  ObservableList<String> get favorites {
    _$favoritesAtom.context.enforceReadPolicy(_$favoritesAtom);
    _$favoritesAtom.reportObserved();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<String> value) {
    _$favoritesAtom.context.conditionallyRunInAction(() {
      super.favorites = value;
      _$favoritesAtom.reportChanged();
    }, _$favoritesAtom, name: '${_$favoritesAtom.name}_set');
  }

  final _$favoritesAsStoryComponentsAtom =
      Atom(name: 'FavoritesStoreBase.favoritesAsStoryComponents');

  @override
  ObservableList get favoritesAsStoryComponents {
    _$favoritesAsStoryComponentsAtom.context
        .enforceReadPolicy(_$favoritesAsStoryComponentsAtom);
    _$favoritesAsStoryComponentsAtom.reportObserved();
    return super.favoritesAsStoryComponents;
  }

  @override
  set favoritesAsStoryComponents(ObservableList value) {
    _$favoritesAsStoryComponentsAtom.context.conditionallyRunInAction(() {
      super.favoritesAsStoryComponents = value;
      _$favoritesAsStoryComponentsAtom.reportChanged();
    }, _$favoritesAsStoryComponentsAtom,
        name: '${_$favoritesAsStoryComponentsAtom.name}_set');
  }

  final _$_reloadFavoritesAsyncAction = AsyncAction('_reloadFavorites');

  @override
  Future<void> _reloadFavorites() {
    return _$_reloadFavoritesAsyncAction.run(() => super._reloadFavorites());
  }

  final _$FavoritesStoreBaseActionController =
      ActionController(name: 'FavoritesStoreBase');

  @override
  void retry() {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadFavorites() {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction();
    try {
      return super.loadFavorites();
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addFavorite(DocumentSnapshotModel story) {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction();
    try {
      return super.addFavorite(story);
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFavorite(String documentId) {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction();
    try {
      return super.removeFavorite(documentId);
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
