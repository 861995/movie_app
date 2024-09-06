import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.showBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.kPrimaryColor,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.kWhiteColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      elevation: 0,
      title: Text(
        title,
        style: AppFonts.boldFont.copyWith(
          fontSize: 35,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: <Color>[
                AppColors.kSecondaryColor,
                AppColors.kTertiaryColor
              ],
            ).createShader(
              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
            ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
