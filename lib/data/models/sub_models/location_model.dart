import 'package:flutter_application_bloc_state_management/core/network/api_end_points.dart';

class LocationModel {
  final String name;
  final String url;

  LocationModel({required this.name, required this.url});

  factory LocationModel.formjson(Map<String, dynamic> json) {
    return LocationModel(name: json[ApiKeys.name], url: json[ApiKeys.url]);
  }
}
