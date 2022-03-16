import 'package:chopper/chopper.dart';
import 'package:flutter_starter_kit/common/dataclass/result.dart';

typedef NetworkEntityToDomainEntityMap<NetworkEntity, DomainEntity>
    = DomainEntity? Function(NetworkEntity? dto);

typedef CreateNetworkCall<NetworkEntity> = Future<NetworkEntity?> Function();

abstract class BaseRepository {
  Future<Result<DomainEntity?>> makeNetworkCall<NetworkEntity, DomainEntity>(
      {required CreateNetworkCall<Response<NetworkEntity>> networkCall,
      required NetworkEntityToDomainEntityMap<NetworkEntity, DomainEntity>
          map}) async {
    try {
      final response = await networkCall();
      if (response!.isSuccessful) {
        return Result.success(map(response.body!));
      } else {
        return Result.failure<DomainEntity>(
            response.statusCode, response.error);
      }
    } on Exception catch (e) {
      return Result.error<DomainEntity>(e);
    }
  }
}
