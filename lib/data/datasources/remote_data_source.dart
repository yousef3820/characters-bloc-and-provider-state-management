import 'package:flutter_application_bloc_state_management/core/network/api_protocol.dart';
import 'package:flutter_application_bloc_state_management/core/network/network_manager.dart';
import 'package:flutter_application_bloc_state_management/data/models/character_model.dart';

class RemoteDataSource {
  final NetworkManager networkManager;

  RemoteDataSource({required this.networkManager});

  Future<List<CharacterModel>> getAllCharacters() async {
    final result = await networkManager.perform(
      ApiRequest(request: RequestType.getAllCharacters),
    );
    return result;
  }
}
