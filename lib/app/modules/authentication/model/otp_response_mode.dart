class OtpResponseModel {
    OtpResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final OtpData? data;

    factory OtpResponseModel.fromJson(Map<String, dynamic> json){ 
        return OtpResponseModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : OtpData.fromJson(json["data"]),
        );
    }

}

class OtpData {
    OtpData({
        required this.user,
        required this.token,
    });

    final User? user;
    final String? token;

    factory OtpData.fromJson(Map<String, dynamic> json){ 
        return OtpData(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            token: json["token"],
        );
    }

}

class User {
    User({
        required this.id,
        required this.email,
        required this.role,
    });

    final String? id;
    final String? email;
    final String? role;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["_id"],
            email: json["email"],
            role: json["role"],
        );
    }

}
