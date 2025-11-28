import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_state_management/core/service_locator.dart';
import 'package:flutter_application_bloc_state_management/data/models/character_model.dart';
import 'package:flutter_application_bloc_state_management/domain/usecases/get_all_characters_usecase.dart';

class CharacterProvider extends ChangeNotifier {
  final GetAllCharactersUsecase getAllCharacters =
      locator<GetAllCharactersUsecase>();
  bool isLoading = false;
  List<CharacterModel> characters = [];
  String? error;

  Future<void> loadCharacters() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await getAllCharacters.call();

    result.fold(
      (failure) {
        error = failure.errorMessage;
        isLoading = false;
        notifyListeners();
      },
      (success) {
        characters = success;
        isLoading = false;
        notifyListeners();
      },
    );
  }
}
