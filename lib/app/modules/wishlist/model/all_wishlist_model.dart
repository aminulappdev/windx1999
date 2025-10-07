class AllWishlistModel {
    AllWishlistModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<AllWishlistItemModel> data;

    factory AllWishlistModel.fromJson(Map<String, dynamic> json){ 
        return AllWishlistModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllWishlistItemModel>.from(json["data"]!.map((x) => AllWishlistItemModel.fromJson(x))),
        );
    }

}

class AllWishlistItemModel {
    AllWishlistItemModel({
        required this.id,
        required this.author,
        required this.title,
        required this.description,
        required this.link,
        required this.price,
        required this.content,
        required this.token,
        required this.status,
        required this.hideBy,
        required this.contentMeta,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.isVisible,
        required this.isLiked,
        required this.isFollowing,
        required this.isHide,
        required this.isWatchLater,
    });

    final String? id;
    final Author? author;
    final String? title;
    final String? description;
    final String? link;
    final dynamic price;
    final String? content;
    final dynamic token;
    final String? status;
    final List<dynamic> hideBy;
    final ContentMeta? contentMeta;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic v;
    final bool? isVisible;
    final bool? isLiked;
    final bool? isFollowing;
    final bool? isHide;
    final bool? isWatchLater;

    factory AllWishlistItemModel.fromJson(Map<String, dynamic> json){ 
        return AllWishlistItemModel(
            id: json["_id"],
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            title: json["title"],
            description: json["description"],
            link: json["link"],
            price: json["price"],
            content: json["content"],
            token: json["token"],
            status: json["status"],
            hideBy: json["hideBy"] == null ? [] : List<dynamic>.from(json["hideBy"]!.map((x) => x)),
            contentMeta: json["contentMeta"] == null ? null : ContentMeta.fromJson(json["contentMeta"]),
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            isVisible: json["isVisible"],
            isLiked: json["isLiked"],
            isFollowing: json["isFollowing"],
            isHide: json["isHide"],
            isWatchLater: json["isWatchLater"],
        );
    }

  get image => null;

}

class Author {
    Author({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
        required this.profilePublic,
        required this.city,
        required this.country,
        required this.state,
        required this.street,
        required this.zipCode,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;
    final bool? profilePublic;
    final String? city;
    final String? country;
    final String? state;
    final String? street;
    final String? zipCode;

    factory Author.fromJson(Map<String, dynamic> json){ 
        return Author(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            photoUrl: json["photoUrl"],
            profilePublic: json["profilePublic"],
            city: json["city"],
            country: json["country"],
            state: json["state"],
            street: json["street"],
            zipCode: json["zipCode"],
        );
    }

}

class ContentMeta {
    ContentMeta({
        required this.id,
        required this.like,
        required this.likeBy,
        required this.comment,
        required this.share,
    });

    final String? id;
    final int? like;
    final List<dynamic> likeBy;
    final int? comment;
    final int? share;

    factory ContentMeta.fromJson(Map<String, dynamic> json){ 
        return ContentMeta(
            id: json["_id"],
            like: json["like"],
            likeBy: json["likeBy"] == null ? [] : List<dynamic>.from(json["likeBy"]!.map((x) => x)),
            comment: json["comment"],
            share: json["share"],
        );
    }

}

class Meta {
    Meta({
        required this.page,
        required this.limit,
        required this.total,
        required this.totalPage,
    });

    final int? page;
    final int? limit;
    final int? total;
    final int? totalPage;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPage: json["totalPage"],
        );
    }

}
