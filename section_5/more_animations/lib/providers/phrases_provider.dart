import 'package:animated_list/models/phrase_model.dart';
import 'package:animated_list/utils/word_generator.dart';
import 'package:flutter/foundation.dart';

class PhrasesProvider extends ChangeNotifier {
  PhrasesProvider() {
    _initiate();
  }

  final List<PhraseModel> _phrases = [];
  final List<PhraseModel> _likedPhrases = [];

  List<PhraseModel> get phrases => _phrases;
  List<PhraseModel> get likedPhrases => _likedPhrases;

  void _initiate() {
    var random = generateRandomPhrases(5);
    for (var ran in random) {
      _phrases.add(PhraseModel(ran));
    }
  }

  void addRandomItemToList() {
    _phrases.add(PhraseModel(generateRandomPhrase()));
    notifyListeners();
  }

  void addItemToList(PhraseModel phrase, int index) {
    _phrases.insert(index, phrase);
    notifyListeners();
  }

  void removeItemFromList(int index) {
    _phrases.removeAt(index);
    notifyListeners();
  }

  int get length {
    if (_phrases != null) {
      return _phrases.length;
    } else {
      return 0;
    }
  }

  void likeItem(int index) {
    _phrases[index].likeOrDislike();
    if (_phrases[index].like == true) {
      _likedPhrases.add(_phrases[index]);
    } else {
      _likedPhrases
          .removeWhere((phrase) => phrase.phrase == _phrases[index].phrase);
    }
    notifyListeners();
  }
}
