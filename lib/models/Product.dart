import 'package:json_annotation/json_annotation.dart';
import 'Category.dart';

part 'Product.g.dart';

@JsonSerializable()
class Product {
   String id;
  final String title, description;
   final List<String> ? images;
  final double rating, price;
  final bool isFavourite, isPopular;
  String pdfUrl;

  final Category? category;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.pdfUrl,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}