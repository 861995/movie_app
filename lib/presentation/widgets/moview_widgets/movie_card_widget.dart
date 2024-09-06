import 'package:Keeto_Movies/domain/entity/movie_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../provider/movie_provider.dart';
import '../../screens/overView_screen.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_const_text.dart';
import '../../utils/app_fonts.dart';
import 'movie_rating_widget.dart';
import 'movie_title_widget.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieEntity movieEntity;
  const MovieCardWidget({required this.movieEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<MovieProvider>(context, listen: false).movieDetailEntity =
            null;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieOverViewScreen(
              imageUrl: movieEntity.posterPath!,
              movieEntity: movieEntity,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 230.h,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 10, right: 5, bottom: 5, top: 5),
                  height: 205.h,
                  width: 130.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Hero(
                      tag: "${movieEntity.posterPath}",
                      child: CachedNetworkImage(
                        imageUrl: movieEntity.posterPath! ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 20,
                  child: MovieRatingWidget(
                    value: movieEntity.rating!.toInt(),
                  ),
                ),
              ],
            ),
          ),
          movieTitleAndReleaseDate(movieEntity),
        ],
      ),
    );
  }

  Widget movieTitleAndReleaseDate(MovieEntity movieEntity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 5),
          constraints: BoxConstraints(maxWidth: 130.w),
          child: MovieTitle(
            movieTitle: movieEntity.title!,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 5),
          constraints: BoxConstraints(maxWidth: 130.w),
          child: Text(
            movieEntity.releaseDate!,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.regular12,
          ),
        ),
      ],
    );
  }
}
