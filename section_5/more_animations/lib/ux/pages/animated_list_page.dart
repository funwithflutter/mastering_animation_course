import 'dart:async';

import 'package:animated_list/models/phrase_model.dart';
import 'package:animated_list/providers/phrases_provider.dart';
import 'package:animated_list/ux/widgets/phrase_list_item.dart';
import 'package:animated_list/ux/widgets/liked_phrases_widget.dart';
import 'package:animated_list/ux/widgets/menu_popup_button.dart';
import 'package:animated_list/ux/widgets/menu_transition_example.dart';
import 'package:animated_list/ux/widgets/rotate_scale_transition.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AnimatedListPage extends StatefulWidget {
  AnimatedListPage({Key key}) : super(key: key);

  @override
  _AnimatedListPageState createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _menuAnimation;

  final _listKey = GlobalKey<AnimatedListState>();
  final _scrollController = ScrollController();

  PhrasesProvider _phrasesProvider;

  @override
  void initState() {
    _phrasesProvider = Provider.of<PhrasesProvider>(context, listen: false);
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMenuPress() {
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.forward) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.reverse) {
      _controller.forward();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _menuAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  void _addRandomItemToList() {
    _phrasesProvider.addRandomItemToList();
    _listKey.currentState.insertItem(_phrasesProvider.length - 1);
    _scrollListToBottom();
  }

  void _addItemToList(PhraseModel phrase, int index) {
    _phrasesProvider.addItemToList(phrase, index);
    _listKey.currentState.insertItem(index);
  }

  void _removeItemFromList(int index) {
    _phrasesProvider.removeItemFromList(
      index,
    );
    _listKey.currentState.removeItem(
      index,
      (_, animation) {
        return Container();
      },
    );
  }

  void _scrollListToBottom() {
    Timer(
      Duration(milliseconds: 100),
      () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phrase Generator'),
        leading: IconButton(
          onPressed: _onMenuPress,
          icon: AnimatedIcon(
            progress: _menuAnimation,
            icon: AnimatedIcons.menu_close,
          ),
        ),
        actions: <Widget>[
          MenuPopupButton(),
        ],
      ),
      floatingActionButton: RotateScaleTransition(
        animation: _menuAnimation,
        child: FloatingActionButton(
          onPressed: _addRandomItemToList,
          child: Icon(Icons.add),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Consumer<PhrasesProvider>(
            builder: (context, phrases, child) {
              return AnimatedList(
                controller: _scrollController,
                key: _listKey,
                initialItemCount: phrases.length,
                itemBuilder: (_, index, animation) {
                  return ScaleTransition(
                    scale: animation.drive(
                      CurveTween(curve: Curves.easeOut),
                    ),
                    child: PhraseListItem(
                      phraseModel: phrases.phrases[index],
                      undoPressed: _addItemToList,
                      index: index,
                      onDismissed: (direction, index) {
                        _removeItemFromList(index);
                      },
                    ),
                  );
                },
              );
            },
          ),
          MenuTransitionExample(
            animation: _controller.view,
            child: LikedPhrasesWidget(),
          )
        ],
      ),
    );
  }
}
