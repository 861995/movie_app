import 'package:flutter/cupertino.dart';

import '../../utils/app_fonts.dart';

class BuildSoftText extends StatelessWidget {
  final String text;
  final int maxLines;
  const BuildSoftText({super.key, required this.text, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    //used for the more detailed text like overview and for the movie category in overview screen
    return Text(
      text,
      maxLines: maxLines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.regular14,
    );
    ;
  }
}
