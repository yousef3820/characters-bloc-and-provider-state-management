import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_state_management/core/service_locator.dart';
import 'package:flutter_application_bloc_state_management/presentation/screens/provider/characters_screen.dart';
// import 'package:flutter_application_bloc_state_management/presentation/screens/characters_screen.dart';
import 'package:flutter_application_bloc_state_management/presentation/state_management/bloc/get_all_characters_bloc.dart';
import 'package:flutter_application_bloc_state_management/presentation/state_management/provider/character_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // BlocProvider(create: (context) => GetAllCharactersBloc()),
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
      ],
      child: MaterialApp(
        color: Colors.grey.shade400,
        home: const CharactersScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
