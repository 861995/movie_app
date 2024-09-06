import 'package:Keeto_Movies/presentation/utils/app_colors.dart';
import 'package:Keeto_Movies/presentation/utils/app_const_text.dart';
import 'package:Keeto_Movies/presentation/widgets/moview_widgets/movie_rating_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/movie_entity.dart';
import '../provider/movie_provider.dart';
import '../utils/app_fonts.dart';
import '../widgets/app_bar.dart';
import '../widgets/overview_widgets/build_genere_text_widget.dart';
import '../widgets/overview_widgets/build_hard_text.dart';
import '../widgets/overview_widgets/build_soft_text.dart';
import '../widgets/cast_widget/cast_widget.dart';
import '../widgets/moview_widgets/movie_title_widget.dart';
import '../widgets/overview_widgets/play_trailer_widget.dart';
import '../widgets/overview_widgets/poster_widget.dart';
import '../widgets/recommendation_widget/recommedation_widget.dart';

class MovieOverViewScreen extends StatelessWidget {
  final String imageUrl;
  final MovieEntity movieEntity;

  const MovieOverViewScreen({
    super.key,
    required this.imageUrl,
    required this.movieEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: const CustomAppBar(
        title: "Movie Overview",
        showBackButton: true,
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.movieDetailEntity == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fetchMovieData(movieProvider, movieEntity.id.toString());
            });
          }

          final movieDetailEntity = movieProvider.movieDetailEntity;

          if (movieProvider.movieDetailEntity == null) {
            if (movieProvider.isMovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (movieProvider.movieDetailErrorMsg.isNotEmpty) {
                return Center(
                  child: Text(
                    movieProvider.movieDetailErrorMsg,
                    style: AppFonts.bold20,
                  ),
                );
              }
              return SizedBox();
            }
          } else {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PosterWidget(
                    backImage: imageUrl,
                    posterImage: movieDetailEntity!.backDropPath!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: MovieTitle(
                      movieTitle: movieDetailEntity.title!,
                    ),
                  ),
                  BuildSoftText(
                    text: movieDetailEntity.releaseDate!,
                    maxLines: 1,
                  ),
                  BuildSoftText(
                    text: movieDetailEntity.runTime!,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 10),
                        child: MovieRatingWidget(
                            value: movieDetailEntity.rating!.toInt()),
                      ),
                      Text(
                        AppConst.userScore,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.bold18,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          color: AppColors.kPrimaryColor,
                          width: 2,
                          height: 20,
                        ),
                      ),
                      certificate(movieDetailEntity.adult!),
                      const PlayTrailerWidget(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: BuildGenereTextWidget(
                              genereList: movieDetailEntity.genere!),
                        ),
                      ],
                    ),
                  ),
                  BuildHardText(text: AppConst.overView),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: BuildSoftText(
                            text: movieDetailEntity.overview!,
                            maxLines: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BuildHardText(text: AppConst.castAndCrew),
                  SizedBox(
                    height: 180.h,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieProvider.castList.length,
                      itemBuilder: (context, i) {
                        var castData = movieProvider.castList[i];
                        return CastWidget(
                          imageUrl: castData.posterPath,
                          role: castData.character,
                          name: castData.name,
                        );
                      },
                    ),
                  ),
                  BuildHardText(text: AppConst.recommendedMovie),
                  Container(
                    height: 130.h,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieProvider.recommendedMovies.length,
                      itemBuilder: (context, i) {
                        return RecommadationWidget(
                          recommendedMovieEntity:
                              movieProvider.recommendedMovies[i],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40), // just for buffer space
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _fetchMovieData(
      MovieProvider movieProvider, String movieId) async {
    try {
      await Future.wait([
        movieProvider.fetchMovieDetails(movieId),
        movieProvider.fetchRecommendation(movieId),
        movieProvider.fetchCast(movieId),
        movieProvider.fetchTrailerVideos(movieId),
      ]);
    } catch (e) {
      print('Error fetching movie data: $e');
    }
  }

  Widget certificate(bool isAdult) {
    return Container(
      height: 25.h,
      width: 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.kPrimaryColor),
      ),
      child: Center(
        child: Text(
          isAdult ? "A" : "UA",
          style: AppFonts.bold18,
        ),
      ),
    );
  }
}
