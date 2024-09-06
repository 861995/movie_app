import 'package:Keeto_Movies/data/data_sources/movie_detail_rs.dart';
import 'package:Keeto_Movies/data/models/movie_detail_model.dart';

import '../../domain/entity/movie_detail_entity.dart';
import '../../domain/repositories/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailRemoteDataSource remoteDataSource;

  MovieDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetailEntity> getMovieDetail(String endpoint) async {
    final MovieDetail movieResponse =
        await remoteDataSource.fetchMovieDetail(endpoint);
    return movieResponse.toEntity();
  }
}
