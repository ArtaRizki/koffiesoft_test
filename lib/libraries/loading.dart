import 'package:flutter/material.dart';

import 'color.dart';

Widget loadingWidget =
    const Center(child: CircularProgressIndicator(strokeWidth: 2));

Widget loadingWidgetFixedSize = const SizedBox(
    width: 40,
    height: 40,
    child: FittedBox(child: CircularProgressIndicator(strokeWidth: 2)));
