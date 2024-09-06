import 'package:json_annotation/json_annotation.dart';
import 'movie_list_models.dart';

part 'movie_response_model.g.dart';

@JsonSerializable()
class MovieResponseModel {
  final Dates dates;
  final int? page;
  final List<MovieModel>? results;
  final int? totalPages;
  final int? totalResults;

  MovieResponseModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      page: json['page'] as int? ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['total_pages'] as int? ?? 0,
      totalResults: json['total_results'] as int? ?? 0,
      dates: json['dates'] == null
          ? Dates()
          : Dates.fromJson(json['dates'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}

@JsonSerializable()
class Dates {
  final String? maximum;
  final String? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
