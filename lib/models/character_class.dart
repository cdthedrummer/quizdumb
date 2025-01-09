class CharacterClass {
  final String name;
  final String emoji;
  final String description;
  final Map<String, double> attributeWeights;
  final List<String> recommendations;

  const CharacterClass({
    required this.name,
    required this.emoji,
    required this.description,
    required this.attributeWeights,
    this.recommendations = const [],
  });
}