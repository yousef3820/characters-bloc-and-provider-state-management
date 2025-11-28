import 'package:dio/dio.dart';
import 'package:flutter_application_bloc_state_management/core/network/api_end_points.dart';
import 'package:flutter_application_bloc_state_management/data/models/character_model.dart';

enum RequestType { getAllCharacters }

abstract class RequestProtocol {
  String get path;
  String get baseUrl => "${ApiEndPoints.baseUrl}";
  String get method;
  Map<String, dynamic> get headers => {"Content-type": "application/json"};
  Map<String, dynamic>? get queryParameters;
  Object? get body;
  T performParse<T>(Response response);
}

class ApiRequest<T> extends RequestProtocol {
  final RequestType request;
  final Map<String, dynamic>? extraParams;
  final Object? data;

  ApiRequest({required this.request, this.extraParams, this.data});
  @override
  // TODO: implement body
  Object? get body => data;

  @override
  // TODO: implement method
  String get method => switch (request) {
    // TODO: Handle this case.
    RequestType.getAllCharacters => "GET",
  };

  @override
  // TODO: implement path
  String get path => "${ApiEndPoints.characters}";

  @override
  T performParse<T>(Response response) {
    final data = response.data;
    switch (request) {
      case RequestType.getAllCharacters:
        final result = (data[ApiKeys.result] as List)
            .map((character) => CharacterModel.fromjson(character))
            .toList();
        return result as T;
    }
  }

  @override
  // TODO: implement queryParameters
  Map<String, dynamic>? get queryParameters => extraParams;
}
