class SavePostModel {
    SavePostModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<SavePostItemModel> data;

    factory SavePostModel.fromJson(Map<String, dynamic> json){ 
        return SavePostModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<SavePostItemModel>.from(json["data"]!.map((x) => SavePostItemModel.fromJson(x))),
        );
    }

}

class SavePostItemModel {
    SavePostItemModel({
        required this.id,
        required this.user,
        required this.modelType,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final User? user;
    final String? modelType;
    final Content? content;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory SavePostItemModel.fromJson(Map<String, dynamic> json){ 
        return SavePostItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            modelType: json["modelType"],
            content: json["content"] == null ? null : Content.fromJson(json["content"]),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class Content {
    Content({
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
        required this.video,
        required this.title,
        required this.link,
        required this.price,
        required this.token,
        required this.status,
    });

    final String? id;
    final String? author;
    final String? description;
    final List<String> content;
    final String? audience;
    final ContentMeta? contentMeta;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final List<String> hideBy;
    final String? video;
    final String? title;
    final String? link;
    final int? price;
    final int? token;
    final String? status;

    factory Content.fromJson(Map<String, dynamic> json){ 
        return Content(
            id: json["_id"],
            author: json["author"],
            description: json["description"],
            content: json["content"] == null ? [] : List<String>.from(json["content"]!.map((x) => x)),
            audience: json["audience"],
            contentMeta: json["contentMeta"] == null ? null : ContentMeta.fromJson(json["contentMeta"]),
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            hideBy: json["hideBy"] == null ? [] : List<String>.from(json["hideBy"]!.map((x) => x)),
            video: json["video"],
            title: json["title"],
            link: json["link"],
            price: json["price"],
            token: json["token"],
            status: json["status"],
        );
    }

}

class ContentMeta {
    ContentMeta({
        required this.id,
        required this.like,
        required this.comment,
        required this.view,
        required this.share,
    });

    final String? id;
    final int? like;
    final int? comment;
    final int? view;
    final int? share;

    factory ContentMeta.fromJson(Map<String, dynamic> json){ 
        return ContentMeta(
            id: json["_id"],
            like: json["like"],
            comment: json["comment"],
            view: json["view"],
            share: json["share"],
        );
    }

}

class User {
    User({
        required this.id,
        required this.name,
        required this.photoUrl,
    });

    final String? id;
    final String? name;
    final String? photoUrl;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["_id"],
            name: json["name"],
            photoUrl: json["photoUrl"],
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
