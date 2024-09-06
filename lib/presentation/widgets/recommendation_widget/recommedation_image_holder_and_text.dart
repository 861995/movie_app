import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RecommendationImagePlaceholder extends StatelessWidget {
  final String imageUrl;

  const RecommendationImagePlaceholder({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 215.w, // Responsive width
        height: 100.h, // Responsive height
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.white.withOpacity(0.5),
          child: Container(
            width: 215.w, // Match the size of the actual image
            height: 100.h, // Match the size of the actual image
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        alignment: Alignment.center,
      ),
    );
  }
}

class RecommendationText extends StatelessWidget {
  final String title;
  final int userLikes;
  final TextStyle style;

  const RecommendationText({
    required this.title,
    required this.userLikes,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final int percentage = (userLikes * 10).toInt();
    return SizedBox(
      width: 215.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              title,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
          Flexible(
            child: Text(
              "${percentage}%",
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
