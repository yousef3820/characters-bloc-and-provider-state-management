import 'package:flutter_application_bloc_state_management/core/network/api_end_points.dart';
import 'package:flutter_application_bloc_state_management/data/models/sub_models/location_model.dart';
import 'package:flutter_application_bloc_state_management/data/models/sub_models/origin_model.dart';

class CharacterModel{
  final int id;
  final String species;
  final String type;
  final OriginModel origin;
  final LocationModel location;
  final String url;
  final String created;
  final String name;
  final String status;
  final String gender;
  final String image;
  final List<dynamic> episode;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromjson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json[ApiKeys.id],
      name: json[ApiKeys.name],
      status: json[ApiKeys.status],
      species: json[ApiKeys.species],
      type: json[ApiKeys.type],
      gender: json[ApiKeys.gender],
      origin: OriginModel.fromjson(json[ApiKeys.origin]),
      location: LocationModel.formjson(json[ApiKeys.location]),
      image: json[ApiKeys.image],
      episode: json[ApiKeys.episode],
      url: json[ApiKeys.url],
      created: json[ApiKeys.created],
    );
  }
}
