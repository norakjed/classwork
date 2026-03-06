class User {
  final String name;
  final List<String> favoriteSongs;

  User({required this.name, required this.favoriteSongs});

  User copyWith({String? name, List<String>? favoriteSongs}) {
    return User(
      name: name ?? this.name,
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
    );
  }
}
