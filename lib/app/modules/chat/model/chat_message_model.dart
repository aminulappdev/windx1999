class ChatMessageModel {
  ChatMessageModel({
     this.success,
     this.statusCode,
     this.message,
     this.data,
  }); 

  final bool? success;
  final int? statusCode;
  final String? message;
  final List<MessageData>? data;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<MessageData>.from(json["data"].map((x) => MessageData.fromJson(x))),
    );
  }
}

class MessageData {
  final String? id;
  final String? text;
  final bool? seen;
  final Receiver? sender;
  final Receiver? receiver;
  final String? chat;
  final List<String> imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  static var obs;

  MessageData({
    this.id,
    this.text,
    this.seen,
    this.sender,
    this.receiver,
    this.chat,
    this.imageUrl = const [],
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json["_id"],
      text: json["text"],
      seen: json["seen"],
      sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
      receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
      chat: json["chat"],
      imageUrl: json["imageUrl"] == null
          ? []
          : List<String>.from(json["imageUrl"].map((x) => x.toString())),
      createdAt: json["createdAt"] == null ? null : DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: json["updatedAt"] == null ? null : DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class Receiver {
  Receiver({
    required this.id,
    required this.name,
    required this.email, 
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
    );
  }
}
