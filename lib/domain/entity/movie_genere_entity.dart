import '../../core/movie_genere/movie_genere_const.dart';

class Genre {
  static const Map<int, String> genreMap = movieGenreMap;

  static String getGenreName(int id) {
    return genreMap[id] ?? 'Unknown';
  }
}
