class LoginResponse {
  bool? success;
  String? message;
  String? result;

  LoginResponse({this.success, this.message, this.result});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['result'] = this.result;
    return data;
  }
}
