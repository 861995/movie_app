class MovieEntity {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backDropPath;
  final double? rating;
  final String? releaseDate;
  final List<String>? genere;
  final bool? adult;

  MovieEntity({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.backDropPath,
    this.rating,
    this.releaseDate,
    this.genere,
    this.adult,
  });
}
