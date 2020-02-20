import 'package:random_words/random_words.dart';

List<String> generateRandomPhrases(int amount) {
  final nouns = generateNoun().take(amount).toList();
  final adjectives = generateAdjective().take(amount).toList();
  return List<String>.generate(amount, (index) {
    return '${adjectives[index]} ${nouns[index]}';
  });
}

String generateRandomPhrase() {
  final phrase = generateRandomPhrases(1);
  return phrase[0];
}
