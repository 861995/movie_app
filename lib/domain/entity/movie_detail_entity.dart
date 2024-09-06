class MovieDetailEntity {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backDropPath;
  final double? rating;
  final String? releaseDate;
  final String? runTime;
  final List<String>? genere;
  final bool? adult;

  MovieDetailEntity({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.backDropPath,
    this.rating,
    this.releaseDate,
    this.runTime,
    this.genere,
    this.adult,
  });
}
