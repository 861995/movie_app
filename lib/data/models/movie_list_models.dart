import 'package:Keeto_Movies/core/env/app_env.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movie_genere_entity.dart';

part 'movie_list_models.g.dart';

@JsonSerializable()
class MovieModel {
  final int? id;
  final bool? adult;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<int>? genreIds;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genreIds,
    required this.adult,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      releaseDate: json['release_date'] as String? ?? '',
      adult: json['adult'] as bool? ?? false,
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  //method to pair the genere id from api and used to store in entity
  List<String> getGenreNames(List<int>? genreIds) {
    try {
      if (genreIds == null) return [];
      return genreIds.map((id) => Genre.getGenreName(id)).toList();
    } catch (e) {
      return [];
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

  MovieEntity toEntity() {
    return MovieEntity(
      backDropPath: AppEnv.getImagePath(backdropPath!),
      adult: adult!,
      releaseDate: formattedReleaseDate(releaseDate!),
      genere: getGenreNames(genreIds),
      id: id!,
      title: title!,
      overview: overview!,
      posterPath: AppEnv.getImagePath(posterPath!),
      rating: voteAverage!,
    );
  }
}
