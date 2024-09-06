import 'dart:convert';
import 'package:Keeto_Movies/data/models/trailer_video_model.dart';
import 'package:http/http.dart' as http;

class TrailerVideosRemoteDataSource {
  final http.Client client;

  TrailerVideosRemoteDataSource({required this.client});

  Future<List<Video>> fetchTrailerVideo(String endpoint) async {
    final response = await client.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final videosJson = jsonResponse['results'] as List<dynamic>;
      return videosJson
          .map((json) => Video.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load trailer');
    }
  }
}
