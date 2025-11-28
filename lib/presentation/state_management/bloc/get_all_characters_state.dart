part of 'get_all_characters_bloc.dart';

@immutable
sealed class GetAllCharactersState {}

final class GetAllCharactersInitial extends GetAllCharactersState {}

final class GetAllCharactersLoading extends GetAllCharactersState {}

final class GetAllCharactersSuccess extends GetAllCharactersState {
  final List<CharacterEntity> characters;

  GetAllCharactersSuccess({required this.characters});
}

final class GetAllCharactersFailure extends GetAllCharactersState {
  final String errorMessage;

  GetAllCharactersFailure({required this.errorMessage});
}
