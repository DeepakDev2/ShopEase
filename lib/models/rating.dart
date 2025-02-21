class Rating {
  final String UserId;
  final double rating;

  Rating({
    required this.UserId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": UserId,
      "rating": rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    // print(map["rating"].toDouble().runtimeType);
    return Rating(
      UserId: map["userId"] ?? "",
      rating: map["rating"]?.toDouble() ?? 0,
    );
  }
}
