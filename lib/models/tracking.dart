// ignore_for_file: file_names

class TrackingModel {
  late final String tokenId;
  late String operSys;
  late int userType;
  late int userLang;
  late double Lang;
  late double Lat;

  TrackingModel({
    required this.tokenId,
    required this.operSys,
    required this.userType,
    required this.userLang,
    required this.Lang,
    required this.Lat,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenId'] = tokenId;
    data['OperSys'] = operSys;
    data['userType'] = userType;
    data['UserLang'] = userLang;
    data['Lang'] = Lang;
    data['Lat'] = Lat;
    return data;
  }
}
