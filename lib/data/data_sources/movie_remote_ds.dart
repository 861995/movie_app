import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_response_model.dart';

class MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSource({required this.client});

  Future<MovieResponseModel> fetchMovies(String endpoint) async {
    final response = await client.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return MovieResponseModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
