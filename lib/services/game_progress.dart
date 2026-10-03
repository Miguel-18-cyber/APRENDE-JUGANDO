import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProgress extends ChangeNotifier {
  GameProgress._();

  static final GameProgress instance = GameProgress._();
  static const xpPerLevel = 100;

  int _xp = 0;
  final Map<String, int> _winsByWorld = {};
  bool _loaded = false;

  int get xp => _xp;
  int get level => (_xp ~/ xpPerLevel) + 1;
  int get xpInLevel => _xp % xpPerLevel;
  bool get isLoaded => _loaded;
  int winsFor(String world) => _winsByWorld[world] ?? 0;
  int get totalWins => _winsByWorld.values.fold(0, (sum, value) => sum + value);
  Set<String> get exploredWorlds => _winsByWorld.entries
      .where((entry) => entry.value > 0)
      .map((entry) => entry.key)
      .toSet();

  List<GameAchievement> get achievements => [
        GameAchievement(
          id: 'first_win',
          title: 'Primera chispa',
          description: 'Completa tu primer desafío.',
          icon: '✨',
          unlocked: totalWins >= 1,
        ),
        GameAchievement(
          id: 'five_wins',
          title: 'Mente curiosa',
          description: 'Completa 5 desafíos.',
          icon: '🧠',
          unlocked: totalWins >= 5,
        ),
        GameAchievement(
          id: 'ten_wins',
          title: 'Explorador experto',
          description: 'Completa 10 desafíos.',
          icon: '🧭',
          unlocked: totalWins >= 10,
        ),
        GameAchievement(
          id: 'all_worlds',
          title: 'Viajero de mundos',
          description: 'Gana un desafío en cada mundo.',
          icon: '🌌',
          unlocked: exploredWorlds.length >= 4,
        ),
        GameAchievement(
          id: 'level_five',
          title: 'Estrella ascendente',
          description: 'Alcanza el nivel 5.',
          icon: '🏅',
          unlocked: level >= 5,
        ),
      ];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _xp = prefs.getInt('game_xp') ?? 0;
    for (final world in worlds) {
      _winsByWorld[world] = prefs.getInt('wins_$world') ?? 0;
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> recordWin(String world) async {
    if (!_loaded || !worlds.contains(world)) return;
    _xp += 10;
    _winsByWorld[world] = winsFor(world) + 1;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('game_xp', _xp);
    await prefs.setInt('wins_$world', winsFor(world));
  }

  Future<void> awardBonusXp(int amount) async {
    if (!_loaded || amount <= 0) return;
    _xp += amount;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('game_xp', _xp);
  }

  static const worlds = ['Letras', 'Números', 'Memoria', 'Color Grid'];
}

class GameAchievement {
  const GameAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
  });

  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;
}
