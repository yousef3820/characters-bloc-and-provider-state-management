import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_state_management/domain/entities/character_entity.dart';
import 'package:flutter_application_bloc_state_management/presentation/state_management/provider/character_provider.dart';
import 'package:flutter_application_bloc_state_management/presentation/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterEntity> charactes;
  late List<CharacterEntity> searchedCharacters;
  bool isSearching = false;
  bool _wasOffline = false;

  final _searchController = TextEditingController();
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "find a character....",
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18),
      ),
      style: TextStyle(fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedItemsToSearchList(searchedCharacter);
      },
    );
  }

  void addSearchedItemsToSearchList(String searchedCharacter) {
    searchedCharacters = charactes
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  void _loadCharacters() {
    // context.read<GetAllCharactersBloc>().add(LoadCharactersEvent());
    Provider.of<CharacterProvider>(context).loadCharacters();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharacterProvider>(context, listen: false).loadCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching
          ? AppBar(
              backgroundColor: Colors.amber,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => isSearching = false);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(child: _buildSearchField()),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                  icon: Icon(Icons.cancel),
                ),
              ],
            )
          : AppBar(
              backgroundColor: Colors.amber,
              title: Text("Characters", style: TextStyle(color: Colors.black)),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
      body: OfflineBuilder(
        connectivityBuilder: (context, value, child) {
          final bool connected = !value.contains(ConnectivityResult.none);
          if (connected && _wasOffline) {
            _loadCharacters();
            _wasOffline = false;
          } else if (!connected) {
            _wasOffline = true;
          }
          if (connected) {
            return Consumer<CharacterProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.error != null) {
                  return Center(
                    child: Text(
                      "${provider.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                charactes = provider.characters;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ReorderableGridView.builder(
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            // FIX: adjust index
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }

                            // choose correct list (search or full list)
                            final list = _searchController.text.isEmpty
                                ? charactes
                                : searchedCharacters;

                            final item = list.removeAt(oldIndex);
                            list.insert(newIndex, item);
                          });
                        },
                        shrinkWrap: true, // IMPORTANT
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                        ),
                        itemBuilder: (context, index) {
                          final character = _searchController.text.isEmpty
                              ? charactes[index]
                              : searchedCharacters[index];
                          return Container(
                            key: ValueKey(
                              character.image,
                            ), // IMPORTANT for reorder
                            child: CharacterItem(character: character),
                          );
                        },
                        itemCount: _searchController.text.isEmpty
                            ? provider.characters.length
                            : searchedCharacters.length,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "can\'t connect...check internet",
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                    Image.asset("assets/images/no_internet.png"),
                  ],
                ),
              ),
            );
          }
        },
        child: Center(child: CircularProgressIndicator(color: Colors.amber)),
      ),
    );
  }
}
