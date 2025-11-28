import 'package:flutter_application_bloc_state_management/core/network/network_manager.dart';
import 'package:flutter_application_bloc_state_management/data/datasources/remote_data_source.dart';
import 'package:flutter_application_bloc_state_management/data/repos/get_all_characters_repo_impl.dart';
import 'package:flutter_application_bloc_state_management/domain/usecases/get_all_characters_usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

init() {
  locator.registerLazySingleton<NetworkManager>(() => NetworkManager());

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(networkManager: locator<NetworkManager>()),
  );

  locator.registerLazySingleton<GetAllCharactersRepoImpl>(
    () => GetAllCharactersRepoImpl(dataSource: locator<RemoteDataSource>()),
  );

  locator.registerLazySingleton<GetAllCharactersUsecase>(
    () => GetAllCharactersUsecase(
      getAllCharactersRepo: locator<GetAllCharactersRepoImpl>(),
    ),
  );
}
