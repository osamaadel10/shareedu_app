// ignore: file_names
class EnterModel {
  late final String tokenId;
  late String operSys;
  late int userType;
  late int userLang;

  EnterModel({
    required this.tokenId,
    required this.operSys,
    required this.userType,
    required this.userLang,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenId'] = tokenId;
    data['OperSys'] = operSys;
    data['userType'] = userType;
    data['UserLang'] = userLang;
    return data;
  }
}
