import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cast_model.dart';

class CastRemoteDataSource {
  final http.Client client;

  CastRemoteDataSource({required this.client});

  Future<List<Cast>> fetchCast(String endpoint) async {
    final response = await client.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> castJsonList = jsonResponse['cast'];
      return castJsonList
          .map((json) => Cast.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load cast');
    }
  }
}
