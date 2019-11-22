import 'package:mobx/mobx.dart';
import 'package:manning_live/services/system/preferences_service.dart';
part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  PreferencesService _preferencesService;

  @observable
  bool useDarkMode;

  SettingsStoreBase(this._preferencesService) {
    useDarkMode = _preferencesService.useDarkMode;
  }

  @action
  void setDarkMode(bool updatedDarkModePreference) {
    _preferencesService.useDarkMode = updatedDarkModePreference;
    useDarkMode = updatedDarkModePreference;
  }
}
