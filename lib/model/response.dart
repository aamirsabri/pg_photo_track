class LoginResponse {
  final int status;
  final String statusMessage;
  final String userName;
  final String locationName;
  final String locationCode;

  LoginResponse(
      {required this.status,
      required this.statusMessage,
      required this.userName,
      required this.locationName,
      required this.locationCode});

  Map<String, dynamic> toJson() {
    return ({
      "Status": status.toString(),
      "Status_message": statusMessage,
      "User_name": userName.toString(),
      "Location_name": locationName.toString(),
      "Location_code": locationCode.toString(),
    });
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: int.parse(json['Status']),
      statusMessage: json['Status_message'],
      userName: json['User_name'],
      locationName: json['Location_name'],
      locationCode: json['Location_code'],
    );
  }
}
