class PhraseModel {
  PhraseModel(String phrase)
      : _phrase = phrase,
        _like = false;

  final String _phrase;
  bool _like;

  String get phrase => _phrase;
  bool get like => _like;

  void likeOrDislike() {
    _like = !_like;
  }
}
