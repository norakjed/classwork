import 'package:classwork/W6-Injection-(small_homework)/data/repositories/songs/song_repository.dart';
import 'package:classwork/W6-Injection-(small_homework)/data/repositories/songs/song_repository_remote.dart';
import 'package:classwork/W6-Injection-(small_homework)/main_common.dart';
import 'package:provider/provider.dart';

List<Provider> get providersProduction {
  return [
    Provider<SongRepository>(create: (context) => SongRepositoryRemote()),
  ];
}

void main() {
  mainCommon(providersProduction);
}
