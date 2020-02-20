import 'dart:ui';

import 'package:animated_list/providers/phrases_provider.dart';
import 'package:animated_list/ux/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class LikedPhrasesWidget extends StatelessWidget {
  LikedPhrasesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            salmon.withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Consumer<PhrasesProvider>(
            builder: (context, phrases, child) {
              if (phrases.likedPhrases.isEmpty) {
                return Center(
                  child: Text(
                    'Nothing loved yet :(',
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              }
              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: phrases.likedPhrases.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 200.0,
                        duration: Duration(milliseconds: 500),
                        child: FadeInAnimation(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                ReCase(phrases.likedPhrases[index].phrase)
                                    .titleCase,
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
