import '../entity/trailer_video_entity.dart';

abstract class TrailerVideoRepository {
  Future<List<TrailerVideoEntity>> getTrailer(String endpoint);
}
