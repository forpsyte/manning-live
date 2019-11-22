// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$AuthenticationStore on AuthenticationStoreBase, Store {
  final _$firebaseUserAtom = Atom(name: 'AuthenticationStoreBase.firebaseUser');

  @override
  FirebaseUser get firebaseUser {
    _$firebaseUserAtom.context.enforceReadPolicy(_$firebaseUserAtom);
    _$firebaseUserAtom.reportObserved();
    return super.firebaseUser;
  }

  @override
  set firebaseUser(FirebaseUser value) {
    _$firebaseUserAtom.context.conditionallyRunInAction(() {
      super.firebaseUser = value;
      _$firebaseUserAtom.reportChanged();
    }, _$firebaseUserAtom, name: '${_$firebaseUserAtom.name}_set');
  }

  final _$isLoggedInAtom = Atom(name: 'AuthenticationStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$willRegisterAtom = Atom(name: 'AuthenticationStoreBase.willRegister');

  @override
  bool get willRegister {
    _$willRegisterAtom.context.enforceReadPolicy(_$willRegisterAtom);
    _$willRegisterAtom.reportObserved();
    return super.willRegister;
  }

  @override
  set willRegister(bool value) {
    _$willRegisterAtom.context.conditionallyRunInAction(() {
      super.willRegister = value;
      _$willRegisterAtom.reportChanged();
    }, _$willRegisterAtom, name: '${_$willRegisterAtom.name}_set');
  }

  final _$loadUserFutureAtom =
      Atom(name: 'AuthenticationStoreBase.loadUserFuture');

  @override
  ObservableFuture get loadUserFuture {
    _$loadUserFutureAtom.context.enforceReadPolicy(_$loadUserFutureAtom);
    _$loadUserFutureAtom.reportObserved();
    return super.loadUserFuture;
  }

  @override
  set loadUserFuture(ObservableFuture value) {
    _$loadUserFutureAtom.context.conditionallyRunInAction(() {
      super.loadUserFuture = value;
      _$loadUserFutureAtom.reportChanged();
    }, _$loadUserFutureAtom, name: '${_$loadUserFutureAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: 'AuthenticationStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$_initUserAsyncAction = AsyncAction('_initUser');

  @override
  Future<void> _initUser() {
    return _$_initUserAsyncAction.run(() => super._initUser());
  }

  final _$signInAsyncAction = AsyncAction('signIn');

  @override
  Future<bool> signIn(String authMethod, {String email, String password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(authMethod, email: email, password: password));
  }

  final _$registerAsyncAction = AsyncAction('register');

  @override
  Future<bool> register(String email, String password) {
    return _$registerAsyncAction.run(() => super.register(email, password));
  }

  final _$signOutAsyncAction = AsyncAction('signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$AuthenticationStoreBaseActionController =
      ActionController(name: 'AuthenticationStoreBase');

  @override
  void initUser() {
    final _$actionInfo =
        _$AuthenticationStoreBaseActionController.startAction();
    try {
      return super.initUser();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleForm() {
    final _$actionInfo =
        _$AuthenticationStoreBaseActionController.startAction();
    try {
      return super.toggleForm();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
