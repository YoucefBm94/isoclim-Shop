import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

import 'Product.dart';
part 'Category.g.dart';

enum EnumCategories {
  grilleDiffuseur,
  flexible,
  elementDeSupportage,
  profileAccessoiresDeLaGaine,
  caissonDeVentilation,
  filtration,
}

@JsonSerializable()
class Category {
  final String name;


  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
