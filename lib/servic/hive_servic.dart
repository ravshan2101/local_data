import 'package:hive/hive.dart';
import 'package:local_data/model/user.dart';

class HiveDB {
  var box = Hive.box('pdp_online');

  void storeUser(User user) async {
    box.put('user', user.toJson());
  }

  User loadUser() {
    var user = User.fromJson(box.get('user'));
    return user;
  }

  void removeUser() {
    box.delete('user');
  }
}
