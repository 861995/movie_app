import 'package:Keeto_Movies/data/data_sources/movie_detail_rs.dart';
import 'package:Keeto_Movies/data/repository/cast_repository_imp.dart';
import 'package:Keeto_Movies/data/repository/movie_detail_repository_imp.dart';
import 'package:Keeto_Movies/data/repository/trailer_video_repository-imp.dart';
import 'package:Keeto_Movies/domain/repositories/cast_repository.dart';
import 'package:Keeto_Movies/domain/repositories/movie_detail_repository.dart';
import 'package:Keeto_Movies/domain/repositories/trailer_video_repository.dart';
import 'package:Keeto_Movies/domain/use_cases/get_cast_uc.dart';
import 'package:Keeto_Movies/domain/use_cases/get_movie_detail_uc.dart';
import 'package:Keeto_Movies/domain/use_cases/get_trailer_video_uc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/cast_remote_ds.dart';
import '../../data/data_sources/movie_remote_ds.dart';
import '../../data/data_sources/trailer_videos_remote_ds.dart';
import '../../data/repository/movie_repository_imp.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/use_cases/get_movies_uc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<http.Client>(http.Client());

  // injecting the movie related data
  getIt.registerSingleton<MovieRemoteDataSource>(
    MovieRemoteDataSource(client: getIt<http.Client>()),
  );
  getIt.registerSingleton<MovieRepository>(
    MovieRepositoryImpl(remoteDataSource: getIt<MovieRemoteDataSource>()),
  );
  getIt.registerSingleton<GetMoviesUseCase>(
    GetMoviesUseCase(getIt<MovieRepository>()),
  );

  // injecting the cast related data
  getIt.registerSingleton<CastRemoteDataSource>(
    CastRemoteDataSource(client: getIt<http.Client>()),
  );
  getIt.registerSingleton<CastRepository>(
    CastRepositoryImpl(
      castDataSource: getIt<CastRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<GetCastUseCase>(
    GetCastUseCase(getIt<CastRepository>()),
  );

  // injecting the trailer related data

  getIt.registerSingleton<TrailerVideosRemoteDataSource>(
    TrailerVideosRemoteDataSource(client: getIt<http.Client>()),
  );
  getIt.registerSingleton<TrailerVideoRepository>(
    TrailerVideoRepositoryImpl(
      remoteDataSource: getIt<TrailerVideosRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<GetTrailerVideoUseCase>(
    GetTrailerVideoUseCase(getIt<TrailerVideoRepository>()),
  );

  // injecting the movie detail related data

  getIt.registerSingleton<MovieDetailRemoteDataSource>(
    MovieDetailRemoteDataSource(client: getIt<http.Client>()),
  );
  getIt.registerSingleton<MovieDetailRepository>(
    MovieDetailRepositoryImpl(
      remoteDataSource: getIt<MovieDetailRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<GetMovieDetailUseCase>(
    GetMovieDetailUseCase(getIt<MovieDetailRepository>()),
  );
}
