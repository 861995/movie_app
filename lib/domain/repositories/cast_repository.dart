import 'package:Keeto_Movies/domain/entity/cast_entity.dart';

abstract class CastRepository {
  Future<List<CastEntity>> getCast(String endpoint);
}
