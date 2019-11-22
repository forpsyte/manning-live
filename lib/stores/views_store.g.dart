// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'views_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$ViewsStore on ViewsStoreBase, Store {
  Computed<bool> _$hasViewsComputed;

  @override
  bool get hasViews =>
      (_$hasViewsComputed ??= Computed<bool>(() => super.hasViews)).value;

  final _$viewsAtom = Atom(name: 'ViewsStoreBase.views');

  @override
  ObservableList<String> get views {
    _$viewsAtom.context.enforceReadPolicy(_$viewsAtom);
    _$viewsAtom.reportObserved();
    return super.views;
  }

  @override
  set views(ObservableList<String> value) {
    _$viewsAtom.context.conditionallyRunInAction(() {
      super.views = value;
      _$viewsAtom.reportChanged();
    }, _$viewsAtom, name: '${_$viewsAtom.name}_set');
  }

  final _$addViewAsyncAction = AsyncAction('addView');

  @override
  Future<void> addView(String documentId) {
    return _$addViewAsyncAction.run(() => super.addView(documentId));
  }

  final _$ViewsStoreBaseActionController =
      ActionController(name: 'ViewsStoreBase');

  @override
  void loadViews() {
    final _$actionInfo = _$ViewsStoreBaseActionController.startAction();
    try {
      return super.loadViews();
    } finally {
      _$ViewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearViews() {
    final _$actionInfo = _$ViewsStoreBaseActionController.startAction();
    try {
      return super.clearViews();
    } finally {
      _$ViewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
