// ignore_for_file: file_names, non_constant_identifier_names

class SendLocationModel {
  late String tokenId;
  late double Lang;
  late double Lat;

  SendLocationModel({
    required this.tokenId,
    required this.Lang,
    required this.Lat,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenId'] = tokenId;
    data['Lang'] = Lang;
    data['Lat'] = Lat;
    return data;
  }
}
