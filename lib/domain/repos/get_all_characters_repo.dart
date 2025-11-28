import 'package:dartz/dartz.dart';
import 'package:flutter_application_bloc_state_management/core/errors/failure.dart';
import 'package:flutter_application_bloc_state_management/domain/entities/character_entity.dart';

abstract class GetAllCharactersRepo {
  Future<Either<Failure,List<CharacterEntity>>>getCharacters();
}