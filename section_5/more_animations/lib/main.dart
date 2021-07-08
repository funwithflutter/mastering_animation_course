import 'package:animated_list/ux/pages/animated_list_page.dart';
import 'package:animated_list/providers/theme_provider.dart';
import 'package:animated_list/providers/phrases_provider.dart';
import 'package:animated_list/ux/styles/styles.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeModel(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'More Animations',
          theme: theme.darkMode ? darkTheme : lightTheme,
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: ChangeNotifierProvider(
        create: (context) => PhrasesProvider(),
        child: const AnimatedListPage(),
      ),
    );
  }
}
