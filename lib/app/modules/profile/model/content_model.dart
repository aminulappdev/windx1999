class ContentModel {
    ContentModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<ContentItemModel> data;

    factory ContentModel.fromJson(Map<String, dynamic> json){ 
        return ContentModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<ContentItemModel>.from(json["data"]!.map((x) => ContentItemModel.fromJson(x))),
        );
    }

}

class ContentItemModel {
    ContentItemModel({
        required this.id,
        required this.aboutUs,
        required this.termsAndConditions,
        required this.privacyPolicy,
        required this.supports,
        required this.faq,
        required this.isDeleted,
        required this.banner,
        required this.createdAt,
        required this.updatedAt,
        required this.tokenPrice,
    });

    final String? id;
    final String? aboutUs;
    final String? termsAndConditions;
    final String? privacyPolicy;
    final String? supports;
    final String? faq;
    final bool? isDeleted;
    final List<dynamic> banner;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? tokenPrice;

    factory ContentItemModel.fromJson(Map<String, dynamic> json){ 
        return ContentItemModel(
            id: json["_id"],
            aboutUs: json["aboutUs"],
            termsAndConditions: json["termsAndConditions"],
            privacyPolicy: json["privacyPolicy"],
            supports: json["supports"],
            faq: json["faq"],
            isDeleted: json["isDeleted"],
            banner: json["banner"] == null ? [] : List<dynamic>.from(json["banner"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            tokenPrice: json["tokenPrice"],
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
