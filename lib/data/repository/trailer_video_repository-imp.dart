import 'package:flutter/foundation.dart';

import '../../domain/entity/trailer_video_entity.dart';
import '../../domain/repositories/trailer_video_repository.dart';
import '../data_sources/trailer_videos_remote_ds.dart';

class TrailerVideoRepositoryImpl implements TrailerVideoRepository {
  final TrailerVideosRemoteDataSource remoteDataSource;

  TrailerVideoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TrailerVideoEntity>> getTrailer(String endpoint) async {
    final trailerVideoResponse =
        await remoteDataSource.fetchTrailerVideo(endpoint);
    return trailerVideoResponse
        .map((castModel) => castModel.toEntity())
        .toList();
  }
}
