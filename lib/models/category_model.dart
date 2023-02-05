class CategoryModel {
  CategoryModel({
    required this.genres,
  });

  List<Genre> genres;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );
}
