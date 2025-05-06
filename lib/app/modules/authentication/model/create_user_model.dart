class CreateUserModel {
    CreateUserModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final CreateUserItemModel? data;

    factory CreateUserModel.fromJson(Map<String, dynamic> json){ 
        return CreateUserModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : CreateUserItemModel.fromJson(json["data"]),
        );
    }

}

class CreateUserItemModel {
    CreateUserItemModel({
        required this.user,
        required this.otpToken,
    });

    final User? user;
    final OtpToken? otpToken;

    factory CreateUserItemModel.fromJson(Map<String, dynamic> json){ 
        return CreateUserItemModel(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            otpToken: json["otpToken"] == null ? null : OtpToken.fromJson(json["otpToken"]),
        );
    }

}

class OtpToken {
    OtpToken({
        required this.token,
    });

    final String? token;

    factory OtpToken.fromJson(Map<String, dynamic> json){ 
        return OtpToken(
            token: json["token"],
        );
    }

}

class User {
    User({
        required this.status,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.password,
        required this.gender,
        required this.dateOfBirth,
        required this.isGoogleLogin,
        required this.image,
        required this.tokenAmount,
        required this.role,
        required this.address,
        required this.isDeleted,
        required this.verification,
        required this.firstName,
        required this.lastName,
        required this.bio,
        required this.country,
        required this.state,
        required this.city,
        required this.zipCode,
        required this.street,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? status;
    final String? name;
    final String? email;
    final dynamic phoneNumber;
    final String? password;
    final String? gender;
    final dynamic dateOfBirth;
    final bool? isGoogleLogin;
    final dynamic image;
    final int? tokenAmount;
    final String? role;
    final dynamic address;
    final bool? isDeleted;
    final Verification? verification;
    final String? firstName;
    final String? lastName;
    final String? bio;
    final String? country;
    final String? state;
    final String? city;
    final String? zipCode;
    final String? street;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            status: json["status"],
            name: json["name"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            password: json["password"],
            gender: json["gender"],
            dateOfBirth: json["dateOfBirth"],
            isGoogleLogin: json["isGoogleLogin"],
            image: json["image"],
            tokenAmount: json["tokenAmount"],
            role: json["role"],
            address: json["address"],
            isDeleted: json["isDeleted"],
            verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
            firstName: json["firstName"],
            lastName: json["lastName"],
            bio: json["bio"],
            country: json["country"],
            state: json["state"],
            city: json["city"],
            zipCode: json["zipCode"],
            street: json["street"],
            id: json["_id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Verification {
    Verification({
        required this.otp,
        required this.status,
    });

    final int? otp;
    final bool? status;

    factory Verification.fromJson(Map<String, dynamic> json){ 
        return Verification(
            otp: json["otp"],
            status: json["status"],
        );
    }

}
