import 'package:amazon/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  // final String? userId;
  final List<Rating>? rating;

  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.id,
      required this.rating
      // this.userId,
      });

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    // print(images);
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      "ratings": rating,
      // 'userId': userId,
    };
  }

  // Factory method to create an instance from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    // print(json["ratings"]);
    return Product(
        id: json['_id'] as String?,
        // userId: ['userId'] as String?,
        name: json['name'] as String,
        description: json['description'] as String,
        quantity: (json['quantity'] as num).toDouble(),
        images: List<String>.from(json['images']),
        category: json['category'] as String,
        price: (json['price'] as num).toDouble(),
        rating:
            List<Rating>.from(json["ratings"]?.map((x) => Rating.fromMap(x)))
        //json["ratings"] != null
        //     // ? List<Rating>.from(json["ratings"]?.map((x) => Rating.fromMap(x)))
        //     ? json["rating"]
        //     : null),
        // rating: null,
        );
  }
}
