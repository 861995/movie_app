import 'package:flutter/foundation.dart';

import '../../domain/entity/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/movie_remote_ds.dart';
import '../models/movie_response_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieEntity>> getMovies(String endpoint) async {
    final MovieResponseModel movieResponse =
        await remoteDataSource.fetchMovies(endpoint);
    return movieResponse.results!
        .map((movieModel) => movieModel.toEntity())
        .toList();
  }
}
