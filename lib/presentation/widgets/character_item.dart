import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_state_management/data/models/character_model.dart';
import 'package:flutter_application_bloc_state_management/presentation/screens/character_details_screen.dart';
import 'package:lottie/lottie.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel character;
  const CharacterItem({super.key, required this.character});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CharacterDetailsScreen(character: character),
            ),
          );
        },
        child: GridTile(
          footer: Hero(
            tag: character.image,
            child: Container(
              width: double.infinity,
              color: Colors.black54,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                character.name,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: character.image,
              fit: BoxFit.cover,
              // ---- Show Lottie while loading ----
              placeholder: (context, url) => Center(
                child: Lottie.asset("assets/images/Loading.json", width: 120),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
