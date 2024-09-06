import 'package:flutter/cupertino.dart';

import '../../utils/app_fonts.dart';

class BuildHardText extends StatelessWidget {
  final String text;
  const BuildHardText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.bold20,
            ),
          ),
        ],
      ),
    );
  }
}
