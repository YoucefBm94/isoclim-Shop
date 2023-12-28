// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isFavourite: json['isFavourite'] as bool? ?? false,
      isPopular: json['isPopular'] as bool? ?? false,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      pdfUrl: json['pdfUrl'] as String,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),

    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'rating': instance.rating,
      'price': instance.price,
      'isFavourite': instance.isFavourite,
      'isPopular': instance.isPopular,
      'pdfUrl': instance.pdfUrl,
      'category': instance.category,
    };
