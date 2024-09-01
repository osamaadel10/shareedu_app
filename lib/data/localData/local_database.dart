import '../../constant/varibles/global_varible.dart';

class LocalDatabase {
  static void saveUserIndex(int userIndex) {
    box.write("userIndex", userIndex);
  }

  static void saveUserToken(String userIndex) {
    box.write("userToken", userIndex);
  }

  static int getLanguageCode() {
    return box.read("lang")=='en_US'?1:2;
  }

  static int? getUserIndex() {
    return box.read("userIndex");
  }

  static String? getUserToken() {
    return box.read("userToken");
  }

  static void deletUserData() {
    box.remove("userIndex");
    box.remove("userToken");
  }

  static bool isUserAuthenticated() {
    return (box.hasData("userIndex") &&box.hasData("userToken"));
  }
}
