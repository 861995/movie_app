import 'dart:convert';
import 'package:Keeto_Movies/data/models/movie_detail_model.dart';
import 'package:http/http.dart' as http;
import '../models/cast_model.dart';

class MovieDetailRemoteDataSource {
  final http.Client client;

  MovieDetailRemoteDataSource({required this.client});

  Future<MovieDetail> fetchMovieDetail(String endpoint) async {
    final response = await client.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return MovieDetail.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load cast');
    }
  }
}
