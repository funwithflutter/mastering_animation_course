import 'package:flutter/material.dart';

import 'colors.dart';

BoxDecoration backgroundAuthDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.1, 0.5, 0.9],
      colors: [
        authPageBackgroundColor[700],
        authPageBackgroundColor[600],
        authPageBackgroundColor[400],
      ],
    ),
  );
}

BoxDecoration backgroundHomeDecoration() {
  return BoxDecoration(gradient: linearGradientHomeDecoration());
}

LinearGradient linearGradientHomeDecoration() {
  return LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.1, 0.5, 0.7, 0.9],
    colors: [
      homePageBackgroundColor[800],
      homePageBackgroundColor[700],
      homePageBackgroundColor[600],
      homePageBackgroundColor[400],
    ],
  );
}
