 import '../../../model/user/user.dart';

abstract class UserRepository {
 
  Future<User> getUser();
 
  Future<User> updateUser({String? name, List<String>? favoriteSongs});

}
