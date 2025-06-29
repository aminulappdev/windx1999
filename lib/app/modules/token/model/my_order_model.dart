class MyOrdersModel {
  MyOrdersModel({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<MyOrderItemModel> data;

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<MyOrderItemModel>.from(
              json["data"]!.map((x) => MyOrderItemModel.fromJson(x))),
    );
  }
}

class MyOrderItemModel {
  MyOrderItemModel({
    required this.id,
    required this.user,
    required this.package,
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.paymentStatus,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final User? user;
  final Package? package;
  final String? transactionId;
  final int? amount;
  final String? status;
  final String? paymentStatus;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MyOrderItemModel.fromJson(Map<String, dynamic> json) {
    return MyOrderItemModel(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      package:
          json["package"] == null ? null : Package.fromJson(json["package"]),
      transactionId: json["transactionId"],
      amount: json["amount"],
      status: json["status"],
      paymentStatus: json["paymentStatus"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Package {
  Package({
    required this.id,
    required this.price,
    required this.token,
  });

  final String? id;
  final int? price;
  final int? token;

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json["_id"],
      price: json["price"],
      token: json["token"],
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
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

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
