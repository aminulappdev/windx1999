class OtherProfileModel {
    OtherProfileModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final OtherProfileData? data;

    factory OtherProfileModel.fromJson(Map<String, dynamic> json){ 
        return OtherProfileModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : OtherProfileData.fromJson(json["data"]),
        );
    }

}

class OtherProfileData {
    OtherProfileData({
        required this.id,
        required this.name,
        required this.email,
        required this.username,
        required this.photoUrl,
        required this.banner,
        required this.tokenAmount,
        required this.status,
        required this.isDeleted,
        required this.dataId,
        required this.createdAt,
        required this.updatedAt,
        required this.bio,
        required this.city,
        required this.country,
        required this.state,
        required this.street,
        required this.zipCode,
        required this.profilePublic,
        required this.isFollowing,
        required this.followers,
        required this.following,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? username;
    final String? photoUrl;
    final String? banner;
    final int? tokenAmount;
    final String? status;
    final bool? isDeleted;
    final String? dataId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? bio;
    final String? city;
    final String? country;
    final String? state;
    final String? street;
    final String? zipCode;
    final bool? profilePublic;
    final bool? isFollowing;
    final int? followers;
    final int? following;

    factory OtherProfileData.fromJson(Map<String, dynamic> json){ 
        return OtherProfileData(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            username: json["username"],
            photoUrl: json["photoUrl"],
            banner: json["banner"],
            tokenAmount: json["tokenAmount"],
            status: json["status"],
            isDeleted: json["isDeleted"],
            dataId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            bio: json["bio"],
            city: json["city"],
            country: json["country"],
            state: json["state"],
            street: json["street"],
            zipCode: json["zipCode"],
            profilePublic: json["profilePublic"],
            isFollowing: json["isFollowing"],
            followers: json["followers"],
            following: json["following"],
        );
    }

}
