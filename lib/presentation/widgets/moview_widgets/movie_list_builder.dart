import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/movie_provider.dart';
import '../../utils/app_fonts.dart';
import 'movie_card_widget.dart';

class MovieListBuilder extends StatelessWidget {
  final String title;
  final String movieKey;

  const MovieListBuilder({
    required this.title,
    required this.movieKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        final movies = movieProvider.getMovies(movieKey);
        final isLoading = movieProvider.isLoading(movieKey);
        final errorMessage = movieProvider.getErrorMessage(movieKey);
        if (isLoading) {
          return SizedBox(
              height: 320.h,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (errorMessage.isNotEmpty) {
          return SizedBox(
              height: 320.h,
              child: Center(child: Text('Error: $errorMessage')));
        }
        if (movies.isEmpty) {
          return SizedBox(
              height: 320.h,
              child: const Center(child: Text('No movies available')));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            featureTitle(),
            SizedBox(
              height: 320.h,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: MovieCardWidget(
                      movieEntity: movies[i],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget featureTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: AppFonts.bold20),
    );
  }
}
