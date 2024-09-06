import 'package:Keeto_Movies/core/const_data/const_data.dart';

class AppEnv {
  static const baseUrl = "https://api.themoviedb.org/3/movie/";
  static const baseImageUrl = "https://image.tmdb.org/t/p/original";
  static const popularKey = "upcoming";
  static const topRateKey = "top_rated";
  static const upcomingKey = "popular";
  static String getRelatedMovie(String movieType, {int page = 1}) =>
      "${baseUrl}${movieType}?api_key=${ConstantData.apiKey}&${page.toString()}";
  static String getMovieDetail(
    String movieId,
  ) =>
      "${baseUrl}${movieId}?api_key=${ConstantData.apiKey}";
  static String getCast(String movieId) =>
      "${baseUrl}${movieId}/credits?api_key=${ConstantData.apiKey}";
  static String getTrailer(String movieId) =>
      "${baseUrl}${movieId}/videos?api_key=${ConstantData.apiKey}&&language=en-US";
  static String getImagePath(String imagePath) => "${baseImageUrl}${imagePath}";
}
