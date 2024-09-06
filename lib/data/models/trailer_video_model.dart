import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/trailer_video_entity.dart';

part 'trailer_video_model.g.dart'; // This will be generated

@JsonSerializable()
class Video {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;

  @JsonKey(name: 'iso_3166_1')
  final String iso31661;

  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;

  @JsonKey(name: 'published_at')
  final DateTime publishedAt;

  final String id;

  Video({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  // factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      iso6391: json['iso_639_1'] ?? "",
      iso31661: json['iso_3166_1'] ?? "",
      name: json['name'] ?? "",
      key: json['key'] ?? "",
      site: json['site'] ?? "",
      size: json['size'] ?? 0,
      type: json['type'] ?? "",
      official: json['official'] ?? false,
      publishedAt: DateTime.parse(json['published_at']),
      id: json['id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => _$VideoToJson(this);

  TrailerVideoEntity toEntity() {
    return TrailerVideoEntity(
      id: id,
      name: name,
      type: type,
      isOfficial: official,
      videoKey: key,
    );
  }
}
