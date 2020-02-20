import 'package:animated_list/ux/pages/animated_list_page.dart';
import 'package:animated_list/providers/theme_provider.dart';
import 'package:animated_list/providers/phrases_provider.dart';
import 'package:animated_list/ux/styles/styles.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        builder: (context) => ThemeModel(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
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
        builder: (context) => PhrasesProvider(),
        child: AnimatedListPage(),
      ),
    );
  }
}
