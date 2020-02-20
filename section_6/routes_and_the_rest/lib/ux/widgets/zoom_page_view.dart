import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../repository/content_provider.dart';
import '../styles/styles.dart';
import 'logo_container.dart';

const scaleFraction = 0.7;
const fullScale = 1.0;

class ZoomPageScroll extends StatefulWidget {
  const ZoomPageScroll(
      {Key key, @required this.pageController, @required this.value})
      : super(key: key);

  final PageController pageController;
  final ValueNotifier<double> value;

  @override
  _ZoomPageScrollState createState() => _ZoomPageScrollState();
}

class _ZoomPageScrollState extends State<ZoomPageScroll> {
  static const double _scrollBarHeight = 200.0;
  static const int _initialPage = 2; //todo

  PageController get _pageController => widget.pageController;

  double page = 2.0;
  int _currentPage = _initialPage;

  bool _scrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      widget.value.value = _pageController.position.pixels /
          _pageController.position.maxScrollExtent;
      setState(() {
        page = _pageController.page;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content[_currentPage].title,
            style: GoogleFonts.sourceCodePro(
              fontSize: 46,
              color: gummentalColor,
            ),
          ),
        ),
        SizedBox(
          height: _scrollBarHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollNotification,
            child: PageView.builder(
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              controller: _pageController,
              itemCount: content.length,
              itemBuilder: (context, index) {
                final scale =
                    max(scaleFraction, (fullScale - (index - page).abs()));
                return LogoContainer(
                  content: content[index],
                  scale: scale,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
