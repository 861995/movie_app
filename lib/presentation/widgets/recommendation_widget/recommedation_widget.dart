import 'package:Keeto_Movies/presentation/utils/app_fonts.dart';
import 'package:Keeto_Movies/presentation/widgets/recommendation_widget/recommedation_image_holder_and_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entity/movie_entity.dart';
import '../../utils/app_colors.dart';
import '../cast_widget/cast_text_and_image.dart';

class RecommadationWidget extends StatelessWidget {
  final MovieEntity recommendedMovieEntity;
  const RecommadationWidget({super.key, required this.recommendedMovieEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
            width: 215.w,
            child: RecommendationImagePlaceholder(
              imageUrl: recommendedMovieEntity.posterPath!,
            ),
          ),
          RecommendationText(
            title: recommendedMovieEntity.title!,
            style: AppFonts.regular14,
            userLikes: recommendedMovieEntity.rating!.toInt(),
          )
        ],
      ),
    );
  }
}
