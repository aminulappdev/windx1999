class CommentModel {
    CommentModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<CommentItemModel> data;

    factory CommentModel.fromJson(Map<String, dynamic> json){ 
        return CommentModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<CommentItemModel>.from(json["data"]!.map((x) => CommentItemModel.fromJson(x))),
        );
    }

}

class CommentItemModel {
    CommentItemModel({
        required this.id,
        required this.user,
        required this.modelType,
        required this.content,
        required this.comment,
        required this.isReply,
        required this.replyRef,
        required this.reply,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final User? user;
    final String? modelType;
    final String? content;
    final String? comment;
    final bool? isReply;
    final String? replyRef;
    final List<dynamic> reply;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory CommentItemModel.fromJson(Map<String, dynamic> json){ 
        return CommentItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            modelType: json["modelType"],
            content: json["content"],
            comment: json["comment"],
            isReply: json["isReply"],
            replyRef: json["replyRef"],
            reply: json["reply"] == null ? [] : List<dynamic>.from(json["reply"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
