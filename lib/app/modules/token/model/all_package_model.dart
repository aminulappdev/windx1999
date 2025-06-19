class AllPackageModel {
    AllPackageModel({
        required this.success,
        required this.message,
        required this.meta,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Meta? meta;
    final List<AllPackageItemMOdel> data;

    factory AllPackageModel.fromJson(Map<String, dynamic> json){ 
        return AllPackageModel(
            success: json["success"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllPackageItemMOdel>.from(json["data"]!.map((x) => AllPackageItemMOdel.fromJson(x))),
        );
    }

}

class AllPackageItemMOdel {
    AllPackageItemMOdel({
        required this.id,
        required this.price,
        required this.token,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final int? price;
    final int? token;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory AllPackageItemMOdel.fromJson(Map<String, dynamic> json){ 
        return AllPackageItemMOdel(
            id: json["_id"],
            price: json["price"],
            token: json["token"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
