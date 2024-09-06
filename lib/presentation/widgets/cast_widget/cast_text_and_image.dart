import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CastImagePlaceholder extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CastImagePlaceholder({
    required this.imageUrl,
    required this.width,
    required this.height,
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
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.white.withOpacity(0.5),
          child: Container(
            color: Colors.white,
            width: width,
            height: height,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          "assets/image/no_image.jpeg",
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}

class CastText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const CastText({
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              text,
              maxLines: 2,
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
