import 'package:dartz/dartz.dart';
import 'package:flutter_application_bloc_state_management/core/errors/failure.dart';
import 'package:flutter_application_bloc_state_management/domain/entities/character_entity.dart';
import 'package:flutter_application_bloc_state_management/domain/repos/get_all_characters_repo.dart';

class GetAllCharactersUsecase {
  final GetAllCharactersRepo getAllCharactersRepo;

  GetAllCharactersUsecase({required this.getAllCharactersRepo});

  Future<Either<Failure, List<CharacterEntity>>> call() {
    return getAllCharactersRepo.getCharacters();
  }
}
