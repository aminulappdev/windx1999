class ResendOtpResponseModel {
    ResendOtpResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final ResendOtpData? data;

    factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json){ 
        return ResendOtpResponseModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : ResendOtpData.fromJson(json["data"]),
        );
    }

}

class ResendOtpData {
    ResendOtpData({
        required this.token,
    });

    final String? token;

    factory ResendOtpData.fromJson(Map<String, dynamic> json){ 
        return ResendOtpData(
            token: json["token"],
        );
    }

}
