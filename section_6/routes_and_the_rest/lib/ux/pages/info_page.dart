import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/content_model.dart';
import '../styles/styles.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({
    Key key,
    @required this.content,
  }) : super(key: key);

  final ContentModel content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(color: greyBlueColor),
          Align(
            alignment: Alignment.bottomCenter,
            child: Villain(
              villainAnimation: VillainAnimation.fromBottom(
                from: const Duration(milliseconds: 300),
                to: const Duration(milliseconds: 600),
              ),
              child: FractionallySizedBox(
                heightFactor: 0.75,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: gummentalColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 10,
                            offset: Offset(7, 7),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: FractionallySizedBox(
                      heightFactor: 0.7,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            content.description,
                            style: GoogleFonts.notoSans(
                                fontSize: 18, color: antiFlashColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.8),
            child: FractionallySizedBox(
              heightFactor: 0.3,
              child: Hero(
                tag: content.titleTag,
                child: Image.asset(content.logoLocation),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
