import 'package:Keeto_Movies/domain/entity/cast_entity.dart';
import 'package:Keeto_Movies/domain/entity/trailer_video_entity.dart';
import 'package:Keeto_Movies/domain/repositories/cast_repository.dart';
import 'package:Keeto_Movies/domain/repositories/trailer_video_repository.dart';

class GetTrailerVideoUseCase {
  final TrailerVideoRepository repository;

  GetTrailerVideoUseCase(this.repository);

  Future<List<TrailerVideoEntity>> execute(String endpoint) {
    return repository.getTrailer(endpoint);
  }
}
