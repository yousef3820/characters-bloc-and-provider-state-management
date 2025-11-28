import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_state_management/domain/entities/character_entity.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterEntity character;
  const CharacterDetailsScreen({super.key , required this.character});
  Widget _buildText(String title, String value)
  {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            )
          ),
        ]
      ),
    );
  }

  Widget _buildDivider(double endIndent)
  {
    return Divider(
      height: 30,
      endIndent: endIndent ,
      color: Colors.amber,
      thickness: 2,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.blueGrey,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.name,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              background: Hero(tag: character.image, child:
                Image.network(character.image, fit: BoxFit.cover,)
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText("status: ", character.status),
                  _buildDivider(300),
                  _buildText("Name: ", character.name),
                  _buildDivider(300),
                  _buildText("Gender: ", character.gender),
                  _buildDivider(300),
                  _buildText("N0. of Episodes: ", character.episode.length.toString()),
                  _buildDivider(300),
                ],
              ),
            ),
            const SizedBox(height: 500,)
          ]))
        ],
      ),
    );
  }
}