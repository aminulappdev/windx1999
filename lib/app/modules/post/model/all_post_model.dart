class AllPostModel {
    AllPostModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<AllPostItemModel> data;

    factory AllPostModel.fromJson(Map<String, dynamic> json){ 
        return AllPostModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllPostItemModel>.from(json["data"]!.map((x) => AllPostItemModel.fromJson(x))),
        );
    }

}

class AllPostItemModel {
    AllPostItemModel({
        required this.id,
        required this.author,
        required this.description,
        required this.content,
        required this.audience,
        required this.contentMeta,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.hideBy,
        required this.isLiked,
        required this.isVisible,
        required this.isHide,
        required this.isWatchLater,
        required this.contentType,
        required this.title,
        required this.link,
        required this.price,
        required this.token,
        required this.status,
        required this.reason,
    });

    final String? id;
    final Author? author;
    final String? description;
    final List<String> content;
    final String? audience;
    final ContentMeta? contentMeta;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final List<String> hideBy;
    final bool? isLiked;
    final bool? isVisible;
    final bool? isHide;
    final bool? isWatchLater;
    final String? contentType;
    final String? title;
    final String? link;
    final int? price;
    final int? token;
    final String? status;
    final String? reason;

    factory AllPostItemModel.fromJson(Map<String, dynamic> json){ 
        return AllPostItemModel(
            id: json["_id"],
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            description: json["description"],
            content: json["content"] == null ? [] : List<String>.from(json["content"]!.map((x) => x)),
            audience: json["audience"],
            contentMeta: json["contentMeta"] == null ? null : ContentMeta.fromJson(json["contentMeta"]),
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            hideBy: json["hideBy"] == null ? [] : List<String>.from(json["hideBy"]!.map((x) => x)),
            isLiked: json["isLiked"],
            isVisible: json["isVisible"],
            isHide: json["isHide"],
            isWatchLater: json["isWatchLater"],
            contentType: json["contentType"],
            title: json["title"],
            link: json["link"],
            price: json["price"],
            token: json["token"],
            status: json["status"],
            reason: json["reason"],
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
