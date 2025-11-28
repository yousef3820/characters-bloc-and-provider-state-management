part of 'get_all_characters_bloc.dart';

@immutable
sealed class GetAllCharactersEvent {}

class LoadCharactersEvent extends GetAllCharactersEvent{}