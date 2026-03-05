import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  @override
  List<String> getRecentSongIds() => ['101', '102'];
}
