import 'package:flutter/cupertino.dart';

import '../../utils/app_fonts.dart';

class MovieTitle extends StatelessWidget {
  final String movieTitle;
  const MovieTitle({super.key, required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      movieTitle,
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.bold18,
    );
  }
}
