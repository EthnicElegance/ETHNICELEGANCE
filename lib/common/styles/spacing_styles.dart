import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class ESpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: ESizes.appBarHeight,
    left: ESizes.defaultSpace,
    bottom: ESizes.defaultSpace,
    right: ESizes.defaultSpace,
  );
}