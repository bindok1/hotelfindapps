class Property {
  Property({
    required this.id,
    required this.name,
    required this.cover,
    required this.images,
    required this.price,
    required this.location,
    required this.rate,
    required this.description,
    required this.activities,
    required this.category,
  });

  final String? id;
  final String? name;
  final String? cover;
  final List<String> images;
  final int? price;
  final String? location;
  final double? rate;
  final String? description;
  final List<Map<String, dynamic>> activities;
  final String? category;

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"],
      name: json["name"],
      cover: json["cover"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      price: json["price"],
      location: json["location"],
      rate: json["rate"],
      description: json["description"],
      activities: json["activites"] == null
          ? []
          : List<Map<String, dynamic>>.from(json["activites"]),
      category: json["category"],
    );
  }
}
