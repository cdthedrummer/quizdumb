class CharacterClass {
  final String name;
  final String title;
  final String emoji;
  final String description;
  final String primaryStat;
  final String secondaryStat;
  final Map<String, int> minimumStats;
  final List<String> keyTraits;
  final List<String> growthAreas;
  final List<String> suggestedActivities;

  const CharacterClass({
    required this.name,
    required this.title,
    required this.emoji,
    required this.description,
    required this.primaryStat,
    required this.secondaryStat,
    required this.minimumStats,
    required this.keyTraits,
    required this.growthAreas,
    required this.suggestedActivities,
  });

  @override
  String toString() {
    return 'CharacterClass{name: $name, primary: $primaryStat, secondary: $secondaryStat}';
  }
}