class AllBlockersModel {
    AllBlockersModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<AllBolckersItemModel> data;

    factory AllBlockersModel.fromJson(Map<String, dynamic> json){ 
        return AllBlockersModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllBolckersItemModel>.from(json["data"]!.map((x) => AllBolckersItemModel.fromJson(x))),
        );
    }

}

class AllBolckersItemModel {
    AllBolckersItemModel({
        required this.id,
        required this.blocker,
        required this.blocked,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final Blocke? blocker;
    final Blocke? blocked;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory AllBolckersItemModel.fromJson(Map<String, dynamic> json){ 
        return AllBolckersItemModel(
            id: json["_id"],
            blocker: json["blocker"] == null ? null : Blocke.fromJson(json["blocker"]),
            blocked: json["blocked"] == null ? null : Blocke.fromJson(json["blocked"]),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Blocke {
    Blocke({
        required this.id,
        required this.name,
        required this.photoUrl,
    });

    final String? id;
    final String? name;
    final String? photoUrl;

    factory Blocke.fromJson(Map<String, dynamic> json){ 
        return Blocke(
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
