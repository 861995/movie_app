import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import 'cast_text_and_image.dart';

class CastWidget extends StatelessWidget {
  final String imageUrl;
  final String role;
  final String name;

  const CastWidget({
    required this.imageUrl,
    required this.role,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
            width: 115.w,
            child: CastImagePlaceholder(
              imageUrl: imageUrl,
              width: 115.w,
              height: 100.h,
            ),
          ),
          CastText(
            text: role,
            style: AppFonts.bold18,
          ),
          CastText(
            text: name,
            style: AppFonts.regular12.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
