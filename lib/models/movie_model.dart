class MovieModel {
  MovieModel({
    required this.id,
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  int id;
  int page;
  List<MovieListModel> movies;
  int totalPages;
  int totalResults;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        page: json["page"],
        movies: List<MovieListModel>.from(
            json["results"].map((x) => MovieListModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class MovieListModel {
  MovieListModel({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.itemCount,
    required this.iso6391,
    required this.listType,
    required this.name,
    this.posterPath,
  });

  String description;
  int favoriteCount;
  int id;
  int itemCount;
  String iso6391;
  String listType;
  String name;
  String? posterPath;

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        description: json["description"],
        favoriteCount: json["favorite_count"],
        id: json["id"],
        itemCount: json["item_count"],
        iso6391: json["iso_639_1"],
        listType: json["list_type"]!,
        name: json["name"],
        posterPath: json["poster_path"],
      );
}
