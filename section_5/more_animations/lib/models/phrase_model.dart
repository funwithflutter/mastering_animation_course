class PhraseModel {
  final String _phrase;
  bool _like;

  PhraseModel(String phrase)
      : _phrase = phrase,
        _like = false;

  String get phrase => _phrase;
  bool get like => _like;

  void likeOrDislike() {
    _like = !_like;
  }
}