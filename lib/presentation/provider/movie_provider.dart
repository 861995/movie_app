import 'package:Keeto_Movies/core/env/app_env.dart';
import 'package:Keeto_Movies/domain/entity/cast_entity.dart';
import 'package:Keeto_Movies/domain/entity/movie_detail_entity.dart';
import 'package:Keeto_Movies/domain/entity/trailer_video_entity.dart';
import 'package:Keeto_Movies/domain/use_cases/get_cast_uc.dart';
import 'package:Keeto_Movies/domain/use_cases/get_movie_detail_uc.dart';
import 'package:Keeto_Movies/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/injection/injection_container.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/use_cases/get_movies_uc.dart';
import '../../domain/use_cases/get_trailer_video_uc.dart';

class MovieProvider with ChangeNotifier {
  final GetMoviesUseCase _getMoviesUseCase = getIt<GetMoviesUseCase>();
  final GetCastUseCase _getCastUseCase = getIt<GetCastUseCase>();
  final GetMovieDetailUseCase _getMovieDetailUseCase =
      getIt<GetMovieDetailUseCase>();
  final GetTrailerVideoUseCase _getTrailerUseCase =
      getIt<GetTrailerVideoUseCase>();

  final Map<String, List<MovieEntity>> _movies = {};
  final Map<String, bool> _loadingStatus = {};
  final Map<String, String> _errorMessages = {};

  bool _isRecommendationLoading = false;
  List<MovieEntity> _recommendedMovies = [];
  String _recommendationErrorMessage = "";
  bool _isMovieDetailLoading = false;
  String _movieDetailErrorMsg = "";

  bool _isCastLoading = false;
  List<CastEntity> _castList = [];
  String _castErrorMessage = "";

  List<TrailerVideoEntity> _trailerList = [];
  MovieDetailEntity? movieDetailEntity;

  // getter for movies
  List<MovieEntity> getMovies(String movieType) => _movies[movieType] ?? [];
  bool isLoading(String movieType) => _loadingStatus[movieType] ?? false;
  String getErrorMessage(String movieType) => _errorMessages[movieType] ?? "";

  //getter for recommeded movies
  bool get isRecommendationLoading => _isRecommendationLoading;
  List<MovieEntity> get recommendedMovies => _recommendedMovies;
  String get recommendationErrorMessage => _recommendationErrorMessage;

  //getter for cast
  bool get isCastLoading => _isCastLoading;
  List<CastEntity> get castList => _castList;
  String get castErrorMessage => _castErrorMessage;

  bool get isMovieDetailLoading => _isMovieDetailLoading;
  String get movieDetailErrorMsg => _movieDetailErrorMsg;
  // getter for video
  List<TrailerVideoEntity> get trailerList => _trailerList;

  Future<void> fetchMovies(String movieType, {int page = 1}) async {
    print("helloworddd");
    if (_loadingStatus[movieType] == true) return;

    _loadingStatus[movieType] = true;
    notifyListeners();

    try {
      _movies[movieType] = await _getMoviesUseCase
          .execute(AppEnv.getRelatedMovie(movieType, page: page));
      _errorMessages[movieType] = "";
    } catch (e) {
      _movies[movieType] = [];
      _errorMessages[movieType] = "ERROR DETECTED";
    } finally {
      _loadingStatus[movieType] = false;
      notifyListeners();
    }
  }

  // method to fetch the recommended movie list inside the movie overview screen
  Future<void> fetchRecommendation(String movieId, {int page = 1}) async {
    if (_isRecommendationLoading == true) return;

    _isRecommendationLoading = true;
    notifyListeners();
    try {
      _recommendedMovies = await _getMoviesUseCase.execute(
          AppEnv.getRelatedMovie("${movieId}/recommendations", page: page));
      _recommendationErrorMessage = "";
    } catch (e) {
      _recommendedMovies = [];
      _recommendationErrorMessage = "ERROR DETECTED";
    } finally {
      _isRecommendationLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCast(String movieId) async {
    if (_isCastLoading == true) return;

    _isCastLoading = true;
    notifyListeners();
    try {
      _castList = await _getCastUseCase.execute(AppEnv.getCast(movieId));
      _castErrorMessage = "";
    } catch (e) {
      _castList = [];
      _castErrorMessage = "ERROR DETECTED";
    } finally {
      _isCastLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTrailerVideos(String movieId) async {
    try {
      _trailerList =
          await _getTrailerUseCase.execute(AppEnv.getTrailer(movieId));
    } catch (e) {
      _trailerList = [];
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchMovieDetails(String movieId) async {
    if (_isMovieDetailLoading == true) return;
    _isMovieDetailLoading = true;
    notifyListeners();
    try {
      movieDetailEntity =
          await _getMovieDetailUseCase.execute(AppEnv.getMovieDetail(movieId));
      _movieDetailErrorMsg = "";
    } catch (e) {
      movieDetailEntity = null;
      _movieDetailErrorMsg = "ERROR DETECTED";
    } finally {
      _isMovieDetailLoading = false;
      notifyListeners();
    }
  }

  Future<String> findTrailer() async {
    String trailerKey = "";
    try {
      if (_trailerList.isNotEmpty) {
        trailerKey = _trailerList
            .firstWhere(
              (video) => video.isOfficial && video.type == "Trailer",
            )
            .videoKey;
      } else {
        showToast("No trailer found");
      }
    } catch (e) {
      showToast("Error : ${e.toString()}");
    }

    return trailerKey;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.kPrimaryColor,
      textColor: AppColors.kWhiteColor,
      fontSize: 16.sp,
    );
  }
}
