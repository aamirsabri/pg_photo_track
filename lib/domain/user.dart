class UserModel {
  String? userId;
  String? password;
  String? imei;
  String? appNo;
  String? locationCode;
  String? locationName;

  UserModel({
    required this.userId,
    required this.password,
    this.imei,
    this.appNo,
    this.locationCode,
    this.locationName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      password: json['password'],
      imei: json['imei'],
      appNo: json['appNo'],
      locationCode: json['locationCode'],
      locationName: json['locationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'password': password,
      'imei': imei,
      'appNo': appNo,
      'locationCode': locationCode,
      'locationName': locationName,
    };
  }
}
