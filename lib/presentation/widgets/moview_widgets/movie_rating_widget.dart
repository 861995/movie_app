import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';

class MovieRatingWidget extends StatelessWidget {
  final int value;
  const MovieRatingWidget({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final int percentage = (value * 10).toInt();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 35.w,
            height: 35.h,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 3.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(getColorFromValue(percentage)),
              backgroundColor: getColorFromValue(percentage).withOpacity(0.3),
            ),
          ),
          Text(
            '${percentage}%',
            style: AppFonts.boldFont
                .copyWith(color: AppColors.kWhiteColor, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Color getColorFromValue(int value) {
    if (value >= 0 && value < 40) {
      return Colors.red;
    } else if (value >= 40 && value < 75) {
      return Colors.yellow;
    } else if (value >= 75 && value <= 100) {
      return Colors.green;
    } else {
      throw Colors.transparent;
    }
  }
}
