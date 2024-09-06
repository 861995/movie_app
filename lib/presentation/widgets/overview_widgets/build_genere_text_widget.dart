import 'package:flutter/cupertino.dart';

import '../../utils/app_fonts.dart';

class BuildGenereTextWidget extends StatelessWidget {
  final List<String> genereList;
  const BuildGenereTextWidget({super.key, required this.genereList});

  @override
  Widget build(BuildContext context) {
    String genres = genereList.join(', ');
    return Text(
      genres,
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.regular14,
    );
  }
}
