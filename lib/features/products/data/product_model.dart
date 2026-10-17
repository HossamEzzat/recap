import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    price: json['price'],
    image: json['thumbnail'],
    rating: json['rating'],
  );
}
