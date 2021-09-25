import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megacloud/globals.dart' as globals;

class MegaCloudLogo extends StatelessWidget {
  const MegaCloudLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      globals.wayMainLogo,
      height: 47,
      width: 204,
    );
  }
}
