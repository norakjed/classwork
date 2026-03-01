import 'package:classwork/Provider/w6/W6-second_small_homework/data/repositories/settings/app_setting_repository_mock.dart';
import 'package:flutter/widgets.dart';
import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  AppSettingsState(this.repository) {
    init();
  }
  final AppSettingRepositoryMock repository;
  AppSettings? _appSettings;
  bool get isDarkMode => _appSettings?.darkMode ?? false;
  bool get isExplicitEnabled => _appSettings?.explicitContentEnable ?? false;
  Future<void> init() async {
    // Might be used to load data from repository
    _appSettings = await repository.load();
    notifyListeners();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(themeColor: themeColor);
    await repository.save(_appSettings!);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(darkMode: !_appSettings!.darkMode);
    await repository.save(_appSettings!);
    notifyListeners();
  }

  Future<void> toggleExplicit() async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(
      explicitContentEnable: !_appSettings!.explicitContentEnable,
    );
    await repository.save(_appSettings!);
    notifyListeners();
  }
}
