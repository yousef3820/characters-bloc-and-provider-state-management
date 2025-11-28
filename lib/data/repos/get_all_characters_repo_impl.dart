import 'package:dartz/dartz.dart';
import 'package:flutter_application_bloc_state_management/core/errors/failure.dart';
import 'package:flutter_application_bloc_state_management/core/errors/srever_failure.dart';
import 'package:flutter_application_bloc_state_management/data/datasources/remote_data_source.dart';
import 'package:flutter_application_bloc_state_management/domain/entities/character_entity.dart';
import 'package:flutter_application_bloc_state_management/domain/repos/get_all_characters_repo.dart';

class GetAllCharactersRepoImpl extends GetAllCharactersRepo {
  final RemoteDataSource dataSource;

  GetAllCharactersRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<CharacterEntity>>> getCharacters() async {
    try {
      final result = await dataSource.getAllCharacters();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
