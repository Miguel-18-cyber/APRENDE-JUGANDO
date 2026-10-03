import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/achievements_screen.dart';
import 'theme/app_theme.dart';
import 'services/game_progress.dart';
import 'services/rewarded_ad_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GameProgress.instance.load();
  unawaited(RewardedAdService.instance.initialize());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AprendeJugandoApp());
}

class AprendeJugandoApp extends StatelessWidget {
  const AprendeJugandoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aprende Jugando',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      routes: {
        '/play': (_) => const HomeScreen(
              playerName: 'Explorador',
              avatar: '🦊',
            ),
        '/achievements': (_) => const AchievementsScreen(),
      },
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        if (width < 520) return child ?? const SizedBox.shrink();
        return ColoredBox(
          color: const Color(0xFF04020F),
          child: Center(
            child: Container(
              width: 390,
              height: 844,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: const Color(0x55FFFFFF), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66000000),
                    blurRadius: 40,
                    offset: Offset(0, 18),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  size: const Size(390, 844),
                ),
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
      home: const SplashScreen(),
    );
  }
}
