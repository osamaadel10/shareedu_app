class LoginModel {
  final String tokenId;
  String operSys;
  int tuserName;
  String tuserPassword;
  int userType;
  int userLang;

  LoginModel({
    required this.tokenId,
    required this.operSys,
    required this.tuserName,
    required this.tuserPassword,
    required this.userType,
    required this.userLang,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenId'] = tokenId;
    data['OperSys'] = operSys;
    data['TuserName'] = tuserName;
    data['TuserPassword'] = tuserPassword;
    data['userType'] = userType;
    data['UserLang'] = userLang;
    return data;
  }
}
