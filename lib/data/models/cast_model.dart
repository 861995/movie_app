import 'package:Keeto_Movies/domain/entity/cast_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/env/app_env.dart';

part 'cast_model.g.dart';

@JsonSerializable()
class Cast {
  final bool adult;
  final int gender;
  final int id;
  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  final double popularity;
  @JsonKey(name: 'profile_path')
  final String profilePath;
  @JsonKey(name: 'cast_id')
  final int castId;
  final String character;
  @JsonKey(name: 'credit_id')
  final String creditId;
  final int order;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  // factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] as int? ?? 0,
      gender: json['gender'] as int? ?? 0,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      profilePath: json['profile_path'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      castId: json['cast_id'] as int? ?? 0,
      order: json['order'] as int? ?? 0,
      character: json['character'] as String? ?? '',
      creditId: json['credit_id'] as String? ?? '',
      adult: json['adult'] as bool? ?? false,
    );
  }
  Map<String, dynamic> toJson() => _$CastToJson(this);

  CastEntity toEntity() {
    return CastEntity(
      id: id,
      posterPath: AppEnv.getImagePath(profilePath),
      name: name,
      character: character,
    );
  }
}
