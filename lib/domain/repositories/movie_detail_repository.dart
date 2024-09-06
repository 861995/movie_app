import '../entity/movie_detail_entity.dart';

abstract class MovieDetailRepository {
  Future<MovieDetailEntity> getMovieDetail(String endpoint);
}
