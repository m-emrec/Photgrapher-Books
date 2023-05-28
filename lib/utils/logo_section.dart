/*Image.asset(
                  "logo".toPng(),
                  height: size.height * 0.2,
                  width: size.width * 0.6,
                  fit: BoxFit.fill,
                ),
*/

import 'package:flutter/material.dart';
import 'package:photo_book/extensions/image_path_extension.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      "logo".toPng(),
      height: size.height * 0.2,
      width: size.width * 0.6,
      fit: BoxFit.fill,
    );
  }
}
