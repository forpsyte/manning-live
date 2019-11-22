// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$StoriesStore on StoriesStoreBase, Store {
  Computed<List<PostModel>> _$storiesComputed;

  @override
  List<PostModel> get stories =>
      (_$storiesComputed ??= Computed<List<PostModel>>(() => super.stories))
          .value;

  final _$hasNextPageAtom = Atom(name: 'StoriesStoreBase.hasNextPage');

  @override
  bool get hasNextPage {
    _$hasNextPageAtom.context.enforceReadPolicy(_$hasNextPageAtom);
    _$hasNextPageAtom.reportObserved();
    return super.hasNextPage;
  }

  @override
  set hasNextPage(bool value) {
    _$hasNextPageAtom.context.conditionallyRunInAction(() {
      super.hasNextPage = value;
      _$hasNextPageAtom.reportChanged();
    }, _$hasNextPageAtom, name: '${_$hasNextPageAtom.name}_set');
  }

  final _$collectionAtom = Atom(name: 'StoriesStoreBase.collection');

  @override
  ObservableList<PostModel> get collection {
    _$collectionAtom.context.enforceReadPolicy(_$collectionAtom);
    _$collectionAtom.reportObserved();
    return super.collection;
  }

  @override
  set collection(ObservableList<PostModel> value) {
    _$collectionAtom.context.conditionallyRunInAction(() {
      super.collection = value;
      _$collectionAtom.reportChanged();
    }, _$collectionAtom, name: '${_$collectionAtom.name}_set');
  }

  final _$loadCollectionItemsFutureAtom =
      Atom(name: 'StoriesStoreBase.loadCollectionItemsFuture');

  @override
  ObservableFuture get loadCollectionItemsFuture {
    _$loadCollectionItemsFutureAtom.context
        .enforceReadPolicy(_$loadCollectionItemsFutureAtom);
    _$loadCollectionItemsFutureAtom.reportObserved();
    return super.loadCollectionItemsFuture;
  }

  @override
  set loadCollectionItemsFuture(ObservableFuture value) {
    _$loadCollectionItemsFutureAtom.context.conditionallyRunInAction(() {
      super.loadCollectionItemsFuture = value;
      _$loadCollectionItemsFutureAtom.reportChanged();
    }, _$loadCollectionItemsFutureAtom,
        name: '${_$loadCollectionItemsFutureAtom.name}_set');
  }

  final _$loadingNextPageAtom = Atom(name: 'StoriesStoreBase.loadingNextPage');

  @override
  bool get loadingNextPage {
    _$loadingNextPageAtom.context.enforceReadPolicy(_$loadingNextPageAtom);
    _$loadingNextPageAtom.reportObserved();
    return super.loadingNextPage;
  }

  @override
  set loadingNextPage(bool value) {
    _$loadingNextPageAtom.context.conditionallyRunInAction(() {
      super.loadingNextPage = value;
      _$loadingNextPageAtom.reportChanged();
    }, _$loadingNextPageAtom, name: '${_$loadingNextPageAtom.name}_set');
  }

  final _$currentStoryAtom = Atom(name: 'StoriesStoreBase.currentStory');

  @override
  PostModel get currentStory {
    _$currentStoryAtom.context.enforceReadPolicy(_$currentStoryAtom);
    _$currentStoryAtom.reportObserved();
    return super.currentStory;
  }

  @override
  set currentStory(PostModel value) {
    _$currentStoryAtom.context.conditionallyRunInAction(() {
      super.currentStory = value;
      _$currentStoryAtom.reportChanged();
    }, _$currentStoryAtom, name: '${_$currentStoryAtom.name}_set');
  }

  final _$loadNextPageAsyncAction = AsyncAction('loadNextPage');

  @override
  Future<void> loadNextPage() {
    return _$loadNextPageAsyncAction.run(() => super.loadNextPage());
  }

  final _$_loadFirstPageStoriesAsyncAction =
      AsyncAction('_loadFirstPageStories');

  @override
  Future<void> _loadFirstPageStories() {
    return _$_loadFirstPageStoriesAsyncAction
        .run(() => super._loadFirstPageStories());
  }

  final _$_loadInitialStoriesAsyncAction = AsyncAction('_loadInitialStories');

  @override
  Future<void> _loadInitialStories() {
    return _$_loadInitialStoriesAsyncAction
        .run(() => super._loadInitialStories());
  }

  final _$StoriesStoreBaseActionController =
      ActionController(name: 'StoriesStoreBase');

  @override
  void setCurrentStory(PostModel story) {
    final _$actionInfo = _$StoriesStoreBaseActionController.startAction();
    try {
      return super.setCurrentStory(story);
    } finally {
      _$StoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCurrentStory() {
    final _$actionInfo = _$StoriesStoreBaseActionController.startAction();
    try {
      return super.clearCurrentStory();
    } finally {
      _$StoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> refresh() {
    final _$actionInfo = _$StoriesStoreBaseActionController.startAction();
    try {
      return super.refresh();
    } finally {
      _$StoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$StoriesStoreBaseActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$StoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadInitialStories() {
    final _$actionInfo = _$StoriesStoreBaseActionController.startAction();
    try {
      return super.loadInitialStories();
    } finally {
      _$StoriesStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
