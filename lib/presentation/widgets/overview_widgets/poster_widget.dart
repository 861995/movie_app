import 'package:Keeto_Movies/domain/entity/movie_detail_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entity/movie_entity.dart';
import '../../utils/app_colors.dart';

class PosterWidget extends StatelessWidget {
  final String backImage;
  final String posterImage;

  const PosterWidget(
      {super.key, required this.backImage, required this.posterImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          child: Hero(
            tag: "${backImage}",
            child: CachedNetworkImage(
              imageUrl: backImage,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => ColorFiltered(
                colorFilter: ColorFilter.mode(
                  AppColors.kPrimaryColor.withOpacity(0.6),
                  BlendMode.overlay,
                ),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: posterImage!,
              height: 140.h,
              width: 120.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 140.h,
                width: 120.w,
                color: Colors.grey[300],
              ),
              errorWidget: (context, url, error) => Container(
                height: 140.h,
                width: 120.w,
                color: Colors.grey[300],
                child: Icon(Icons.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
