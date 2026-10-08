import 'package:flutter/material.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/features/achievements/screens/achievements_screen.dart';
import 'package:pedali/features/achievements/widgets/achievement_share.dart';
import 'package:pedali/features/achievements/widgets/achievement_ui.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';

class AchievementUnlockScreen extends StatefulWidget {
  const AchievementUnlockScreen({super.key, required this.achievements});

  final List<Achievement> achievements;

  static Route<void> route(List<Achievement> achievements) =>
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => AchievementUnlockScreen(achievements: achievements),
      );

  @override
  State<AchievementUnlockScreen> createState() =>
      _AchievementUnlockScreenState();
}

class _AchievementUnlockScreenState extends State<AchievementUnlockScreen> {
  final _pageController = PageController();

  var _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openAll() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => const AchievementsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final total = widget.achievements.length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: total > 1
                        ? _Dots(count: total, index: _index)
                        : const SizedBox.shrink(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: t.close,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: total,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) =>
                      _AchievementPage(achievement: widget.achievements[i]),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => openAchievementShare(
                    Navigator.of(context),
                    t,
                    widget.achievements[_index],
                  ),
                  icon: const Icon(Icons.ios_share),
                  label: Text(t.shareButton),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: _openAll,
                child: Text(t.viewAllAchievements),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementPage extends StatelessWidget {
  const _AchievementPage({required this.achievement});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    achievement.metric.icon,
                    size: 60,
                    color: cs.onPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  t.achievementUnlocked,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  achievement.label(t),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  achievement.description(t),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == index ? cs.primary : cs.outlineVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
