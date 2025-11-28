import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_state_management/core/service_locator.dart';
import 'package:flutter_application_bloc_state_management/data/models/character_model.dart';
import 'package:flutter_application_bloc_state_management/domain/usecases/get_all_characters_usecase.dart';
import 'package:meta/meta.dart';

part 'get_all_characters_event.dart';
part 'get_all_characters_state.dart';

class GetAllCharactersBloc
    extends Bloc<GetAllCharactersEvent, GetAllCharactersState> {
  final GetAllCharactersUsecase getCharacters =
      locator<GetAllCharactersUsecase>();
  GetAllCharactersBloc() : super(GetAllCharactersInitial()) {
    on<LoadCharactersEvent>((event, emit) async {
      emit(GetAllCharactersLoading());
      final result = await getCharacters.call();
      result.fold(
        (failure) =>
            emit(GetAllCharactersFailure(errorMessage: failure.errorMessage)),
        (success) => emit(GetAllCharactersSuccess(characters: success)),
      );
    });
  }
}
