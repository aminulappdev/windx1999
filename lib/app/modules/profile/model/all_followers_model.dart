class AllFollowersModel {
    AllFollowersModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final List<AllFollowersItemModel> data;

    factory AllFollowersModel.fromJson(Map<String, dynamic> json){ 
        return AllFollowersModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? [] : List<AllFollowersItemModel>.from(json["data"]!.map((x) => AllFollowersItemModel.fromJson(x))),
        );
    }

}

class AllFollowersItemModel {
    AllFollowersItemModel({
        required this.id,
        required this.follower,
        required this.following,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final Follow? follower;
    final Follow? following;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory AllFollowersItemModel.fromJson(Map<String, dynamic> json){ 
        return AllFollowersItemModel(
            id: json["_id"],
            follower: json["follower"] == null ? null : Follow.fromJson(json["follower"]),
            following: json["following"] == null ? null : Follow.fromJson(json["following"]),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Follow {
    Follow({
        required this.id,
        required this.name,
        required this.photoUrl,
    });

    final String? id;
    final String? name;
    final String? photoUrl;

    factory Follow.fromJson(Map<String, dynamic> json){ 
        return Follow(
            id: json["_id"],
            name: json["name"],
            photoUrl: json["photoUrl"],
        );
    }

}
