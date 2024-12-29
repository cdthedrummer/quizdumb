import 'package:flutter/foundation.dart';
import '../models/character_class.dart';
import '../data/character_classes.dart';

class ClassCalculator {
  static const _balanceThreshold = 3; // Increasing threshold to make Jack of All Trades less common
  
  CharacterClass determineClass(Map<String, int> scores) {
    debugPrint('Calculating class for scores: $scores');
    
    // Sort stats from highest to lowest
    var sortedStats = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    debugPrint('Sorted stats: $sortedStats');
    
    // Check for well-rounded character
    if (_isWellRounded(scores)) {
      debugPrint('Character is well-rounded');
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
    if (scores.isEmpty) {
      debugPrint('No scores provided');
      return false;
    }

    var stats = scores.values.toList();
    var maxStat = stats.reduce((max, stat) => max > stat ? max : stat);
    var minStat = stats.reduce((min, stat) => min < stat ? min : stat);
    
    var isBalanced = (maxStat - minStat) <= _balanceThreshold;
    debugPrint('Max stat: $maxStat, Min stat: $minStat, Difference: ${maxStat - minStat}');
    debugPrint('Is balanced? $isBalanced');
    
    return isBalanced;
  }
  
  CharacterClass _findBestMatch(
    String primaryStat, 
    String secondaryStat, 
    Map<String, int> scores
  ) {
    // Find classes matching primary stat
    var potentialClasses = characterClasses.where((c) => 
      c.primaryStat == primaryStat &&
      c.name != 'Jack of All Trades' // Explicitly exclude Jack of All Trades
    ).toList();
    
    debugPrint('Found ${potentialClasses.length} classes with primary stat $primaryStat');
    
    // If no matches, try finding any class where this is a secondary stat
    if (potentialClasses.isEmpty) {
      potentialClasses = characterClasses.where((c) => 
        c.secondaryStat == primaryStat &&
        c.name != 'Jack of All Trades'
      ).toList();
      debugPrint('Found ${potentialClasses.length} alternative classes');
    }
    
    // If still no matches, default to first class for this stat
    if (potentialClasses.isEmpty) {
      debugPrint('No matching classes found, defaulting to first available class');
      return characterClasses.firstWhere(
        (c) => c.name != 'Jack of All Trades',
        orElse: () => characterClasses.first
      );
    }
    
    // Find best match based on secondary stat
    var bestMatch = potentialClasses.firstWhere(
      (c) => c.secondaryStat == secondaryStat,
      orElse: () => potentialClasses.first
    );
    
    debugPrint('Selected class: ${bestMatch.name}');
    return bestMatch;
  }
}