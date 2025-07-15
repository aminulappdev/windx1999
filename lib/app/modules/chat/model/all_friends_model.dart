class AllFriendsModel {
  AllFriendsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<AllFriendsItemModel>? data;

  factory AllFriendsModel.fromJson(Map<String, dynamic> json) {
    return AllFriendsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<AllFriendsItemModel>.from(
              json["data"].map((x) => AllFriendsItemModel.fromJson(x)),
            ),
    );
  }
}

class AllFriendsItemModel {
  AllFriendsItemModel({
    required this.chat,
    required this.message,
    required this.unreadMessageCount,
  });

  final Chat? chat;
  final MessageModel? message;
  final int? unreadMessageCount;

  factory AllFriendsItemModel.fromJson(Map<String, dynamic> json) {
    return AllFriendsItemModel(
      chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
      message:
          json["message"] == null ? null : MessageModel.fromJson(json["message"]),
      unreadMessageCount: json["unreadMessageCount"] ?? 0,
    );
  }
}

class Chat {
  Chat({
    required this.id,
    required this.participants,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final List<Participant> participants;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json["_id"],
      participants: json["participants"] == null
          ? []
          : List<Participant>.from(
              json["participants"].map((x) => Participant.fromJson(x)),
            ),
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class Participant {
  Participant({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
    );
  }
}

class MessageModel {
  MessageModel({
    required this.id,
    required this.text,
    required this.seen,
    required this.sender,
    required this.receiver,
    required this.chat,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? text;
  final bool? seen;
  final String? sender;
  final String? receiver;
  final String? chat;
  final List<dynamic> imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["_id"],
      text: json["text"],
      seen: json["seen"],
      sender: json["sender"],
      receiver: json["receiver"],
      chat: json["chat"],
      imageUrl: json["imageUrl"] ?? [],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}
