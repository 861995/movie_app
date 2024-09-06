import 'package:Keeto_Movies/domain/entity/movie_detail_entity.dart';
import 'package:Keeto_Movies/domain/repositories/movie_detail_repository.dart';

class GetMovieDetailUseCase {
  final MovieDetailRepository repository;

  GetMovieDetailUseCase(this.repository);

  Future<MovieDetailEntity> execute(String endpoint) {
    return repository.getMovieDetail(endpoint);
  }
}
