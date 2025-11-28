import 'package:dartz/dartz.dart';
import 'package:flutter_application_bloc_state_management/core/errors/failure.dart';
import 'package:flutter_application_bloc_state_management/data/models/character_model.dart';

abstract class GetAllCharactersRepo {
  Future<Either<Failure,List<CharacterModel>>>getCharacters();
}