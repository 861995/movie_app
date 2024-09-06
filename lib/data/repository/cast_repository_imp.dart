import 'package:flutter/foundation.dart';

import '../../domain/entity/cast_entity.dart';
import '../../domain/repositories/cast_repository.dart';
import '../data_sources/cast_remote_ds.dart';

class CastRepositoryImpl implements CastRepository {
  final CastRemoteDataSource castDataSource;

  CastRepositoryImpl({required this.castDataSource});

  @override
  Future<List<CastEntity>> getCast(String endpoint) async {
    final castResponse = await castDataSource.fetchCast(endpoint);
    return castResponse.map((castModel) => castModel.toEntity()).toList();
  }
}
