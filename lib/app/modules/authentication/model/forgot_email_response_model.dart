class ForgotEmailResponseModel {
    ForgotEmailResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ForgotEmailData? data;

    factory ForgotEmailResponseModel.fromJson(Map<String, dynamic> json){ 
        return ForgotEmailResponseModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ForgotEmailData.fromJson(json["data"]),
        );
    }

}

class ForgotEmailData {
    ForgotEmailData({
        required this.email,
        required this.token,
    });

    final String? email;
    final String? token;

    factory ForgotEmailData.fromJson(Map<String, dynamic> json){ 
        return ForgotEmailData(
            email: json["email"],
            token: json["token"],
        );
    }

}
