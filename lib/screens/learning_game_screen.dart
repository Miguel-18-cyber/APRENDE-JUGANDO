import 'dart:async';

import 'package:flutter/material.dart';

import '../data/challenge_bank.dart';
import '../services/game_progress.dart';
import '../services/rewarded_ad_service.dart';

import '../theme/app_colors.dart';
import '../widgets/aurora_background.dart';
import '../widgets/glass_panel.dart';

class LearningGameScreen extends StatefulWidget {
  const LearningGameScreen({super.key, required this.world});

  final String world;

  @override
  State<LearningGameScreen> createState() => _LearningGameScreenState();
}

class _LearningGameScreenState extends State<LearningGameScreen> {
  int? _selectedIndex;
  bool _answered = false;
  bool _bonusClaimed = false;
  int _roundIndex = 0;

  GameQuestion get _question {
    final questions = ChallengeBank.forWorld(widget.world);
    return questions[_roundIndex % questions.length];
  }

  Future<void> _answer(int index) async {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
    });
    if (index == _question.correctIndex) {
      await GameProgress.instance.recordWin(widget.world);
    }
  }

  void _continue() {
    setState(() {
      _roundIndex++;
      _selectedIndex = null;
      _answered = false;
      _bonusClaimed = false;
    });
  }

  void _watchBonusAd() {
    final shown = RewardedAdService.instance.showAd(
      onRewardEarned: () {
        if (_bonusClaimed) return;
        _bonusClaimed = true;
        unawaited(GameProgress.instance.awardBonusXp(20));
        if (!mounted) return;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Ganaste 20 XP extra!')),
        );
      },
    );
    if (!shown) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El video todavía no está disponible.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final correct = _selectedIndex == _question.correctIndex;
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: AppColors.text,
                ),
                const SizedBox(height: 12),
                Text(
                  'MUNDO ${widget.world.toUpperCase()}',
                  style: const TextStyle(
                    color: AppColors.aurora,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ronda ${_roundIndex + 1}',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 24),
                GlassPanel(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Text(_question.symbol, style: const TextStyle(fontSize: 54)),
                      const SizedBox(height: 18),
                      Text(
                        _question.prompt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                for (var i = 0; i < _question.answers.length; i++) ...[
                  _AnswerTile(
                    label: _question.answers[i],
                    selected: _selectedIndex == i,
                    correct: _answered && i == _question.correctIndex,
                    onTap: () => _answer(i),
                  ),
                  if (i != _question.answers.length - 1)
                    const SizedBox(height: 10),
                ],
                const Spacer(),
                if (_answered) ...[
                  Text(
                    correct ? '¡Muy bien! +10 XP ✨' : '¡Buen intento! Sigamos aprendiendo 💜',
                    style: TextStyle(
                      color: correct ? AppColors.mint : AppColors.gold,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (_answered)
                  GlowButton(
                    label: 'Jugar otra vez',
                    icon: Icons.replay_rounded,
                    onPressed: _continue,
                    gradient: const [AppColors.aurora, Color(0xFF3B82F6)],
                  )
                else
                  const Center(
                    child: Text(
                      'Toca una respuesta para continuar',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                  ),
                if (_answered && !_bonusClaimed && RewardedAdService.instance.isSupported)
                  AnimatedBuilder(
                    animation: RewardedAdService.instance,
                    builder: (context, _) {
                      final ads = RewardedAdService.instance;
                      if (ads.rewardedThisSession) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Center(
                          child: ads.isAdReady
                              ? TextButton.icon(
                                  onPressed: _watchBonusAd,
                                  icon: const Icon(Icons.ondemand_video_rounded),
                                  label: const Text('ANUNCIO · Ver video y ganar 20 XP'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.gold,
                                  ),
                                )
                              : TextButton.icon(
                                  onPressed: ads.isLoading ? null : ads.retry,
                                  icon: Icon(
                                    ads.isLoading
                                        ? Icons.hourglass_top_rounded
                                        : Icons.refresh_rounded,
                                  ),
                                  label: Text(
                                    ads.isLoading
                                        ? 'Preparando video…'
                                        : 'ANUNCIO · Intentar cargar video',
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.muted,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.label,
    required this.selected,
    required this.correct,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool correct;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = correct
        ? AppColors.mint
        : selected
            ? AppColors.magenta
            : AppColors.glassBorder;
    return GlassPanel(
      padding: EdgeInsets.zero,
      borderRadius: 20,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: selected || correct ? 1.5 : 1),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
