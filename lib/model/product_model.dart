class ProductModel {
  ProductModel({
    required this.id,
    required this.productSerial,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.price,
    required this.country,
    required this.flag,
    required this.rating,
    required this.category,
    required this.subcategory,
  });

  final int id;
  final int productSerial;
  final DateTime? createdAt;
  final String name;
  final String image;
  final int price;
  final String country;
  final String flag;
  final int rating;
  final String category;
  final String subcategory;

  ProductModel copyWith({
    int? id,
    int? productSerial,
    DateTime? createdAt,
    String? name,
    String? image,
    int? price,
    String? country,
    String? flag,
    int? rating,
    String? category,
    String? subcategory,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productSerial: productSerial ?? this.productSerial,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      country: country ?? this.country,
      flag: flag ?? this.flag,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json["id"] ?? 0,
      productSerial: json["product_serial"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      price: json["price"] ?? 0,
      country: json["country"] ?? "",
      flag: json["flag"] ?? "",
      rating: json["rating"] ?? 0,
      category: json["category"] ?? "",
      subcategory: json["subcategory"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_serial": productSerial,
    "created_at": createdAt?.toIso8601String(),
    "name": name,
    "image": image,
    "price": price,
    "country": country,
    "flag": flag,
    "rating": rating,
    "category": category,
    "subcategory": subcategory,
  };

  @override
  String toString(){
    return "$id, $createdAt, $name, $image, $price, $country, $flag, $rating, $category, $subcategory, ";
  }
}
