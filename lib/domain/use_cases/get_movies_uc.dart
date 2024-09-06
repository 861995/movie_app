import '../entity/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<MovieEntity>> execute(String endpoint) {
    return repository.getMovies(endpoint);
  }
}
