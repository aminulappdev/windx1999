class SrapingResponseModel {
  final bool? success;
  final String? message;
  final ScrapingData? data;

  SrapingResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SrapingResponseModel.fromJson(Map<String, dynamic> json) {
    return SrapingResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] == null ? null : ScrapingData.fromJson(json['data']),
    );
  }
}

class ScrapingData {
  final String? title;
  final String? description;
  final double? usdConvertedPrice;
  final String? image;

  ScrapingData({
    required this.title,
    required this.description,
    required this.usdConvertedPrice,
    required this.image,
  });

  factory ScrapingData.fromJson(Map<String, dynamic> json) {
    return ScrapingData(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      usdConvertedPrice: (json['usdConvertedPrice'] is num) ? (json['usdConvertedPrice'] as num?)?.toDouble() : 0.0,
      image: json['image']?.toString() ?? '',
    );
  }
}