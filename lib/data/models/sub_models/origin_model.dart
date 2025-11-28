import 'package:flutter_application_bloc_state_management/core/network/api_end_points.dart';

class OriginModel {
  final String name;
  final String url;

  OriginModel({required this.name, required this.url});

  factory OriginModel.fromjson(Map<String, dynamic> json) {
    return OriginModel(name: json[ApiKeys.name], url: json[ApiKeys.url]);
  }
}
