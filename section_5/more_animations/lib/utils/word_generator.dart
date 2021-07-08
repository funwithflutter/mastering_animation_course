import 'dart:math';

import 'package:english_words/english_words.dart';

List<String> generateRandomPhrases(int amount) {
  final _rand = Random();

  return List<String>.generate(
      amount,
      (index) =>
          '''${adjectives[_rand.nextInt(adjectives.length)]} ${nouns[_rand.nextInt(nouns.length)]}''');
}

String generateRandomPhrase() {
  final phrase = generateRandomPhrases(1);
  return phrase[0];
}
