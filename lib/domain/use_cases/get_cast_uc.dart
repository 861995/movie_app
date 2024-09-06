import 'package:Keeto_Movies/domain/entity/cast_entity.dart';
import 'package:Keeto_Movies/domain/repositories/cast_repository.dart';

class GetCastUseCase {
  final CastRepository repository;

  GetCastUseCase(this.repository);

  Future<List<CastEntity>> execute(String endpoint) {
    return repository.getCast(endpoint);
  }
}
