import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:manning_live/services/system/preferences_service.dart';
import 'package:manning_live/services/authentication/authentication.dart';

part 'authentication_store.g.dart';

class AuthenticationStore = AuthenticationStoreBase with _$AuthenticationStore;

abstract class AuthenticationStoreBase with Store {
  final PreferencesService _preferencesService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  AuthenticationService _service;

  AuthenticationStoreBase(this._preferencesService);

  @observable
  FirebaseUser firebaseUser;

  @observable
  bool isLoggedIn;

  @observable
  bool willRegister = true;

  @observable
  ObservableFuture loadUserFuture;

  @observable
  String errorMessage;

  @action
  void initUser() {
    isLoggedIn = false;
    loadUserFuture = ObservableFuture(_asyncMemoizer.runOnce(() async {
      await _initUser();
    }));
  }

  @action
  Future<void> _initUser() async {
    FirebaseUser user;
    final String authMethod = _preferencesService.authenticationMethod;
    _service = AuthenticationService();
    _service.createFactory(authMethod);
    user = await _service.getCurrentUser();
    if (user != null) {
      firebaseUser = user;
      isLoggedIn = true;
      errorMessage = null;
    }
  }

  @action
  Future<bool> signIn(String authMethod, {String email, String password}) async {
    bool authenticated = false;
    FirebaseUser user;
    final SignInServiceCredentials credentials = SignInServiceCredentials();
    credentials.addCredential('email', email);
    credentials.addCredential('password', password);
    try {
      _service = AuthenticationService();
      _service.createFactory(authMethod);
      user = await _service.signIn(credentials: credentials).catchError((onError) {
        errorMessage = onError.message;
        firebaseUser = null;
      });
      if (user != null) {
        firebaseUser = user;
        errorMessage = null;
        authenticated = true;
        _preferencesService.authenticationMethod = authMethod;
      }
    } catch (error) {
      print(error.message);
      errorMessage = error.message;
    }

    return authenticated;
  }

  @action
  Future<bool> register(String email, String password) async {
    bool authenticated = false;
    _service = AuthenticationService();
    _service.createFactory(AuthenticationService.EMAIL);
    var user = await _service.register(email, password).catchError((onError) {
      errorMessage = onError.message;
      firebaseUser = null;
    });
    if (user != null) {
      firebaseUser = user;
      _preferencesService.authenticationMethod = 'email';
      authenticated = true;
    } else {
      firebaseUser = null;
    }

    return authenticated;
  }

  @action
  void toggleForm() {
    willRegister = !willRegister;
  }

  @action
  Future<void> signOut() async {
    await _service.signOut();
    isLoggedIn = false;
    firebaseUser = null;
  }
}
