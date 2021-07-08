import 'package:flutter/material.dart';
import 'package:flutter_villains/villains/villains.dart';

import 'ux/pages/home.dart';
// import 'ux/transitions/fade_transition_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [VillainTransitionObserver(), routeObserver],
      debugShowCheckedModeBanner: false,
      title: 'Implicit Animations App',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            /// THESE ARE PROVIDED AS EXAMPLES.
            /// They define a MaterialPageRoute page transition animation.
            /// To customize the default MaterialPageRoute page transition
            /// animation for different platforms
            ///
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            // TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            // TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            // TargetPlatform.android: FadeTransitionBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: const Home(),
    );
  }
}
