import '../constant/varibles/global_varible.dart';

class LocalDatabase {
  static void saveUserIndex(int userIndex)async {
    await box.write("userIndex", userIndex);
  }

  static void saveUserToken(String userIndex) async{
    await box.write("userToken", userIndex);
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

  static void deletUserData()async {
    await box.write("userIndex",null);
    await box.write("userToken",null);
  }

  static bool isUserAuthenticated() {
    return (box.hasData("userIndex") &&box.hasData("userToken"));
  }
}
