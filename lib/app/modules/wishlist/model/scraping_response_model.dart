class SrapingResponseModel {
    SrapingResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final Data? data;

    factory SrapingResponseModel.fromJson(Map<String, dynamic> json){ 
        return SrapingResponseModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.title,
        required this.price,
        required this.description,
        required this.image,
        required this.usdConvertedPrice,
    });

    final String? title;
    final String? price;
    final String? description;
    final String? image;
    final double? usdConvertedPrice;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            title: json["title"],
            price: json["price"],
            description: json["description"],
            image: json["image"],
            usdConvertedPrice: json["usdConvertedPrice"],
        );
    }

}
