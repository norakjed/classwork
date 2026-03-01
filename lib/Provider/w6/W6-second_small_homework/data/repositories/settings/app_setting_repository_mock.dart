import 'app_setting_repository.dart';
import '../../../model/settings/app_settings.dart';

class AppSettingRepositoryMock implements AppSettingRepository {
  @override
  Future<AppSettings> load() {
    return Future.value(
      AppSettings(
        themeColor: ThemeColor.blue,
        darkMode: true,
        explicitContentEnable: true,
      ),
    );
  }

  @override
  Future<void> save(AppSettings settings) {
    return Future.value();
  }
}
