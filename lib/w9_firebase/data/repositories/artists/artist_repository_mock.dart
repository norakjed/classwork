import '../../../model/artists/artist.dart';
import 'artist_repository.dart';

class ArtistRepositoryMock implements ArtistRepository {
  final List<Artist> _artists = [];

  @override
  Future<List<Artist>> fetchArtists() async {
    return Future.delayed(Duration(seconds: 2), () => _artists);
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return Future.delayed(Duration(seconds: 2), () {
      return _artists.firstWhere(
        (artist) => artist.id == id,
        orElse: () => throw Exception("No artist with id $id in the database"),
      );
    });
  }
}
