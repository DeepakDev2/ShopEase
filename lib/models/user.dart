class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.address,
      required this.type,
      required this.token,
      required this.cart});

  // Factory method to create a User from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'] as String,
        name: json['name'] as String,
        password: json['password'] as String,
        address: json['address'] as String,
        type: json['type'] as String,
        token: json['token'] as String,
        email: json["email"] as String,
        // cart:  json["cart"] as
        cart: List<Map<String, dynamic>>.from(
            json["cart"]?.map((x) => Map<String, dynamic>.from(x))));
  }

  // Method to convert a User instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'email': email,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
