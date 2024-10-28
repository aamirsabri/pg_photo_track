class LoginResponse {
  final String status;
  final String statusMessage;
  final String? userName;
  final String? locationName;
  final String? locationCode;

  LoginResponse(
      {required this.status,
      required this.statusMessage,
      this.userName,
      this.locationName,
      this.locationCode});

  Map<String, dynamic> toJson() {
    return ({
      "Status": status.toString(),
      "Status_message": statusMessage,
      "User_name": userName,
      "Location_name": locationName,
      "Location_code": locationCode,
    });
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['Status'],
      statusMessage: json['Status_message'],
      userName: json['User_name'],
      locationName: json['Location_name'],
      locationCode: json['Location_code'],
    );
  }
}
