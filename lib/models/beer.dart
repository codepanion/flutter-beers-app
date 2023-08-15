class Beer {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double abv;

  const Beer(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.abv});

  Beer.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        imageUrl = json["image_url"],
        description = json["description"],
        abv = json["abv"].toDouble();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
        'description': description,
        'abv': abv,
      };
}
