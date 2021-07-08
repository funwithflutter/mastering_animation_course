import 'package:animated_list/models/phrase_model.dart';
import 'package:animated_list/ux/styles/my_flutter_app_icons.dart';
import 'package:animated_list/providers/phrases_provider.dart';
import 'package:animated_list/ux/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class PhraseListItem extends StatefulWidget {
  const PhraseListItem({
    Key? key,
    required this.phraseModel,
    required this.index,
    required this.onDismissed,
    required this.undoPressed,
  }) : super(key: key);

  final PhraseModel phraseModel;
  final int index;
  final Function(DismissDirection, int) onDismissed;
  final Function(PhraseModel, int) undoPressed;

  @override
  _PhraseListItemState createState() => _PhraseListItemState();
}

class _PhraseListItemState extends State<PhraseListItem> {
  ValueKey firstIconKey = const ValueKey<String>('like');
  ValueKey secondIconKey = const ValueKey<String>('unlike');

  void _onLikePressed() {
    Provider.of<PhrasesProvider>(context, listen: false).likeItem(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.phraseModel.phrase),
      onDismissed: (direction) {
        widget.onDismissed(direction, widget.index);
        final snackBar = SnackBar(
          content: const Text('Phrase removed'),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Theme.of(context).accentColor,
            onPressed: () {
              widget.undoPressed(widget.phraseModel, widget.index);
            },
          ),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      background: backgroundGradient(salmon, Colors.transparent),
      secondaryBackground: backgroundGradient(Colors.transparent, mustard),
      child: ListTile(
        title: Text(ReCase(widget.phraseModel.phrase).titleCase),
        subtitle: Text('Number: ${widget.index}'),
        trailing: GestureDetector(
          onTap: _onLikePressed,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.easeOut,
            child: widget.phraseModel.like
                ? Icon(
                    MyFlutterApp.heart,
                    key: firstIconKey,
                    color: salmon,
                  )
                : Icon(
                    MyFlutterApp.heart_empty,
                    key: secondIconKey,
                  ),
          ),
        ),
      ),
    );
  }
}
