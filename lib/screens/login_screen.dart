import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/aurora_background.dart';
import '../widgets/glass_panel.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  String _avatar = '🦊';

  static const _avatars = ['🦊', '🐼', '🦄', '🐯', '🐸', '🦉'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _enter() {
    final name = _nameController.text.trim().isEmpty
        ? 'Explorador'
        : _nameController.text.trim();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => HomeScreen(playerName: name, avatar: _avatar),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: AppColors.text,
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea tu perfil',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Elige un avatar cristalino y entra al mundo de juego.',
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 24),
                GlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tu nombre',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _enter(),
                        decoration: const InputDecoration(
                          hintText: 'Cómo te llamamos?',
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.aurora,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Elige tu compañero',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (final avatar in _avatars)
                            GestureDetector(
                              onTap: () => setState(() => _avatar = avatar),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: 58,
                                height: 58,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: _avatar == avatar
                                      ? AppColors.aurora.withOpacity(0.28)
                                      : Colors.white.withOpacity(0.08),
                                  border: Border.all(
                                    color: _avatar == avatar
                                        ? AppColors.aurora
                                        : AppColors.glassBorder,
                                    width: _avatar == avatar ? 1.6 : 1,
                                  ),
                                ),
                                child: Text(
                                  avatar,
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                GlowButton(
                  label: 'Entrar a jugar',
                  icon: Icons.rocket_launch_rounded,
                  gradient: const [AppColors.aurora, Color(0xFF3B82F6)],
                  onPressed: _enter,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
