import 'package:Keeto_Movies/domain/entity/movie_detail_entity.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/env/app_env.dart';
import '../../domain/entity/movie_genere_entity.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetail {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<GenreData> genres;
  final String homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String imdbId;
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompany> productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountry> productionCountries;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int revenue;
  final int runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);

//method to pair the genere id from api and used to store in entity
  List<String> getGenreNames() {
    try {
      return genres.map((genre) => genre.name).toList();
    } catch (e) {
      return [];
    }
  }

  String formattedRuntime() {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours hr $minutes mins';
    } else if (hours > 0) {
      return '$hours hr';
    } else if (minutes > 0) {
      return '$minutes mins';
    } else {
      return 'N/A';
    }
  }

  String formattedReleaseDate(String releaseDate) {
    try {
      final DateTime date = DateTime.parse(releaseDate);
      final DateFormat formatter = DateFormat('MMM d, yyyy');

      return formatter.format(date);
    } catch (e) {
      return "N/A";
    }
  }

  MovieDetailEntity toEntity() {
    return MovieDetailEntity(
      backDropPath: belongsToCollection != null
          ? AppEnv.getImagePath(belongsToCollection!.posterPath)
          : AppEnv.getImagePath(backdropPath),
      adult: adult,
      releaseDate: formattedReleaseDate(releaseDate),
      genere: getGenreNames(),
      id: id,
      title: title,
      overview: overview,
      posterPath: belongsToCollection != null
          ? AppEnv.getImagePath(belongsToCollection!.backdropPath)
          : AppEnv.getImagePath(backdropPath),
      rating: voteAverage,
      runTime: formattedRuntime(),
    );
  }
}

@JsonSerializable()
class BelongsToCollection {
  final int id;
  final String name;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable()
class GenreData {
  final int id;
  final String name;

  GenreData({
    required this.id,
    required this.name,
  });

  factory GenreData.fromJson(Map<String, dynamic> json) =>
      _$GenreDataFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDataToJson(this);
}

@JsonSerializable()
class ProductionCompany {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable()
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  final String iso3166_1;
  final String name;

  ProductionCountry({
    required this.iso3166_1,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}

@JsonSerializable()
class SpokenLanguage {
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso639_1;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
