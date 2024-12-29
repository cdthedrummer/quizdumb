import '../models/character_class.dart';
import '../data/character_classes.dart';

class ClassCalculator {
  static const _balanceThreshold = 2; // Max difference for "balanced" stats
  static const _minimumHighScore = 7;  // Threshold for primary stat
  
  CharacterClass determineClass(Map<String, int> scores) {
    debugPrint('Calculating class for scores: $scores');
    
    // Sort stats from highest to lowest
    var sortedStats = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    debugPrint('Sorted stats: $sortedStats');
    
    // Check for well-rounded character
    if (_isWellRounded(scores)) {
      debugPrint('Determined as well-rounded character');
      return characterClasses.firstWhere((c) => c.name == 'Jack of All Trades');
    }
    
    var primaryStat = sortedStats[0].key;
    var secondaryStat = sortedStats[1].key;
    var primaryValue = sortedStats[0].value;
    
    debugPrint('Primary stat: $primaryStat ($primaryValue)');
    debugPrint('Secondary stat: $secondaryStat');
    
    // Find matching class
    var matchingClass = _findBestMatch(primaryStat, secondaryStat, scores);
    debugPrint('Matched class: ${matchingClass.name}');
    
    return matchingClass;
  }
  
  bool _isWellRounded(Map<String, int> scores) {
    var stats = scores.values.toList();
    var maxStat = stats.reduce((max, stat) => max > stat ? max : stat);
    var minStat = stats.reduce((min, stat) => min < stat ? min : stat);
    
    return (maxStat - minStat) <= _balanceThreshold;
  }
  
  CharacterClass _findBestMatch(
    String primaryStat, 
    String secondaryStat, 
    Map<String, int> scores
  ) {
    // Filter classes that match the primary stat
    var potentialClasses = characterClasses.where((c) => 
      c.primaryStat == primaryStat && 
      _meetsMinimumRequirements(c, scores)
    ).toList();
    
    debugPrint('Found ${potentialClasses.length} potential classes');
    
    // If no matches, fall back to Jack of All Trades
    if (potentialClasses.isEmpty) {
      debugPrint('No matching classes found, defaulting to Jack of All Trades');
      return characterClasses.firstWhere((c) => c.name == 'Jack of All Trades');
    }
    
    // Find best match based on secondary stat
    var bestMatch = potentialClasses.firstWhere(
      (c) => c.secondaryStat == secondaryStat,
      orElse: () => potentialClasses.first
    );
    
    debugPrint('Best match found: ${bestMatch.name}');
    return bestMatch;
  }
  
  bool _meetsMinimumRequirements(CharacterClass characterClass, Map<String, int> scores) {
    return characterClass.minimumStats.entries.every((requirement) {
      var score = scores[requirement.key] ?? 0;
      return score >= requirement.value;
    });
  }
}