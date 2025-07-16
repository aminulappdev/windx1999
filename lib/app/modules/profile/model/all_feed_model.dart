class AllFeedModel {
    AllFeedModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<AllFeedItemModel> data;

    factory AllFeedModel.fromJson(Map<String, dynamic> json){ 
        return AllFeedModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllFeedItemModel>.from(json["data"]!.map((x) => AllFeedItemModel.fromJson(x))),
        );
    }

}

class AllFeedItemModel {
    AllFeedItemModel({
        required this.id,
        required this.author,
        required this.description,
        required this.content,
        required this.audience,
        required this.hideBy,
        required this.contentMeta,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.isLiked,
        required this.isFollowing,
        required this.isVisible,
        required this.isHide,
        required this.isWatchLater,
    });

    final String? id;
    final Author? author;
    final String? description;
    final List<String> content;
    final String? audience;
    final List<dynamic> hideBy;
    final ContentMeta? contentMeta;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final bool? isLiked;
    final bool? isFollowing;
    final bool? isVisible;
    final bool? isHide;
    final bool? isWatchLater;

    factory AllFeedItemModel.fromJson(Map<String, dynamic> json){ 
        return AllFeedItemModel(
            id: json["_id"],
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            description: json["description"],
            content: json["content"] == null ? [] : List<String>.from(json["content"]!.map((x) => x)),
            audience: json["audience"],
            hideBy: json["hideBy"] == null ? [] : List<dynamic>.from(json["hideBy"]!.map((x) => x)),
            contentMeta: json["contentMeta"] == null ? null : ContentMeta.fromJson(json["contentMeta"]),
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            isLiked: json["isLiked"],
            isFollowing: json["isFollowing"],
            isVisible: json["isVisible"],
            isHide: json["isHide"],
            isWatchLater: json["isWatchLater"],
        );
    }

}

class Author {
    Author({
        required this.id,
        required this.name,
        required this.photoUrl,
        required this.profilePublic,
    });

    final String? id;
    final String? name;
    final String? photoUrl;
    final bool? profilePublic;

    factory Author.fromJson(Map<String, dynamic> json){ 
        return Author(
            id: json["_id"],
            name: json["name"],
            photoUrl: json["photoUrl"],
            profilePublic: json["profilePublic"],
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
    final List<String> likeBy;
    final int? comment;
    final int? share;

    factory ContentMeta.fromJson(Map<String, dynamic> json){ 
        return ContentMeta(
            id: json["_id"],
            like: json["like"],
            likeBy: json["likeBy"] == null ? [] : List<String>.from(json["likeBy"]!.map((x) => x)),
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
