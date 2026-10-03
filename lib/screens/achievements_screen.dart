import 'package:flutter/material.dart';

import '../services/game_progress.dart';
import '../theme/app_colors.dart';
import '../widgets/aurora_background.dart';
import '../widgets/glass_panel.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 22, 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(width: 4),
                    const Text('Tus logros',
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: GameProgress.instance,
                  builder: (context, _) {
                    final progress = GameProgress.instance;
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
                      children: [
                        GlassPanel(
                          child: Row(
                            children: [
                              const Text('⭐', style: TextStyle(fontSize: 36)),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nivel ${progress.level}',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                                    Text('${progress.xp} XP · ${progress.totalWins} desafíos completados',
                                        style: const TextStyle(color: AppColors.muted)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Text('Colección de insignias',
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 12),
                        for (final achievement in progress.achievements) ...[
                          _AchievementTile(achievement: achievement),
                          const SizedBox(height: 10),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({required this.achievement});

  final GameAchievement achievement;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      opacity: achievement.unlocked ? 0.17 : 0.08,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: achievement.unlocked
                  ? AppColors.gold.withOpacity(0.18)
                  : Colors.black.withOpacity(0.16),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Text(achievement.unlocked ? achievement.icon : '🔒',
                style: const TextStyle(fontSize: 25)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(achievement.title,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 3),
                Text(achievement.description,
                    style: const TextStyle(color: AppColors.muted, fontSize: 12)),
              ],
            ),
          ),
          if (achievement.unlocked)
            const Icon(Icons.check_circle_rounded, color: AppColors.mint),
        ],
      ),
    );
  }
}
