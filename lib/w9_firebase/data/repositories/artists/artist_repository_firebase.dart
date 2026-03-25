import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  static final Uri baseUri = Uri.https(
    'testing-2b41c-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  static final Uri artistUri = baseUri.replace(path: "/artists.json");

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      final List<Artist> result = [];

      for (var i in artistJson.entries) {
        String id = i.key;
        Map<String, dynamic> data = i.value;
        result.add(ArtistDto.fromJson(id, data));
      }

      return result;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
