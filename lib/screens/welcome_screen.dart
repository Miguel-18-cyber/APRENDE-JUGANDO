import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/aurora_background.dart';
import '../widgets/glass_panel.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GlassPanel(
                    borderRadius: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Text(
                      'v1.0',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Descubre un universo\nde aprendizaje.',
                  style: const TextStyle(
                    fontSize: 38,
                    height: 1.05,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Letras, números, memoria y colores en un mundo cristalino hecho para jugar.',
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                const Row(
                  children: [
                    Expanded(
                      child: _HighlightChip(
                        emoji: '✨',
                        title: 'Misiones',
                        subtitle: 'diarias',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _HighlightChip(
                        emoji: '🏆',
                        title: 'Premios',
                        subtitle: 'brillantes',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GlowButton(
                  label: 'Comenzar la aventura',
                  icon: Icons.play_arrow_rounded,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Retos, premios y diversión · Pensado para familias',
                    style: TextStyle(
                      color: AppColors.muted.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightChip extends StatelessWidget {
  const _HighlightChip({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  final String emoji;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.muted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
