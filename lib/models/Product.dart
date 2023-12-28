import 'package:json_annotation/json_annotation.dart';
import 'Category.dart';
import 'package:uuid/uuid.dart';
part 'Product.g.dart';

const uuid = Uuid();
@JsonSerializable()
class Product {
    String id;
  final String title, description;
    List<String>  images;
  final double rating, price;
  final bool isFavourite, isPopular;
  String pdfUrl;

   late final Category? category;

  Product({
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.pdfUrl,
    required this.category,

  }): id = uuid.v4();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}