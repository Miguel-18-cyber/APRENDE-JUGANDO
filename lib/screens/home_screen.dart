import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../services/game_progress.dart';
import '../widgets/aurora_background.dart';
import '../widgets/glass_panel.dart';
import 'achievements_screen.dart';
import 'learning_game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.playerName,
    required this.avatar,
  });

  final String playerName;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 16),
                  children: [
                    Row(
                      children: [
                        GlassPanel(
                          borderRadius: 22,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            avatar,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hola, $playerName',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Tu racha brilla hoy',
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GlassPanel(
                          borderRadius: 20,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.gold,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '7',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _LevelCard(),
                    const SizedBox(height: 28),
                    Text(
                      'Mundos para explorar',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _WorldCard(
                      title: 'Letras',
                      subtitle: 'Forma palabras mágicas',
                      emoji: '🔤',
                      colors: [Color(0x66C084FC), Color(0x338B5CF6)],
                    ),
                    const SizedBox(height: 12),
                    const _WorldCard(
                      title: 'Números',
                      subtitle: 'Sumas que brillan',
                      emoji: '🔢',
                      colors: [Color(0x665CE1E6), Color(0x332563EB)],
                    ),
                    const SizedBox(height: 12),
                    const _WorldCard(
                      title: 'Memoria',
                      subtitle: 'Encuentra pares ocultos',
                      emoji: '🧠',
                      colors: [Color(0x66FF4D9A), Color(0x33F97316)],
                    ),
                    const SizedBox(height: 12),
                    const _WorldCard(
                      title: 'Color Grid',
                      subtitle: 'Encuentra y combina colores',
                      emoji: '🎨',
                      colors: [Color(0x66FFD166), Color(0x3310B981)],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
                child: GlassPanel(
                  borderRadius: 30,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _NavItem(
                        icon: Icons.home_rounded,
                        label: 'Inicio',
                        selected: true,
                        onTap: () {},
                      ),
                      _NavItem(
                        icon: Icons.explore_rounded,
                        label: 'Mundos',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Explora un mundo para comenzar.'),
                            ),
                          );
                        },
                      ),
                      _NavItem(
                        icon: Icons.emoji_events_rounded,
                        label: 'Logros',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const AchievementsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GameProgress.instance,
      builder: (context, _) {
        final progress = GameProgress.instance;
        return GlassPanel(
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.gold, AppColors.magenta],
                  ),
                ),
                child: Text(
                  '${progress.level}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nivel ${progress.level} · ${progress.xp} XP',
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('${progress.xpInLevel}/100 XP para el siguiente nivel',
                        style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: progress.xpInLevel / GameProgress.xpPerLevel,
                        minHeight: 8,
                        color: AppColors.gold,
                        backgroundColor: const Color(0x33FFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WorldCard extends StatelessWidget {
  const _WorldCard({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.colors,
  });

  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => LearningGameScreen(world: title),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 26)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? AppColors.aurora : AppColors.muted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.text : AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
