import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/map/tile_provider.dart';
import 'package:pedali/core/providers/keep_screen_on_provider.dart';
import 'package:pedali/core/providers/locale_provider.dart';
import 'package:pedali/core/providers/map_style_provider.dart';
import 'package:pedali/core/providers/theme_provider.dart';
import 'package:pedali/core/providers/units_provider.dart';
import 'package:pedali/core/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const supportedLocales = {
    'English': Locale('en'),
    'Українська': Locale('uk'),
    'Español': Locale('es'),
    'Français': Locale('fr'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    final locale = ref.watch(localeProvider);
    final theme = ref.watch(themeProvider);

    final selectedLanguage = supportedLocales.entries
        .firstWhere(
          (entry) => entry.value.languageCode == locale.languageCode,
          orElse: () => supportedLocales.entries.first,
        )
        .key;

    return Scaffold(
      appBar: AppHeader(title: 'Налаштування', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.languageLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedLanguage,
              items: supportedLocales.keys
                  .map(
                    (language) => DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    ),
                  )
                  .toList(),
              onChanged: (language) {
                if (language == null) return;

                ref
                    .read(localeProvider.notifier)
                    .setLocale(supportedLocales[language]!);
              },
            ),

            const SizedBox(height: 24),

            Text(
              t.themeLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<ThemeMode>(
              initialValue: theme,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(t.systemThemeLabel),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(t.lightThemeLabel),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(t.darkThemeLabel),
                ),
              ],
              onChanged: (mode) {
                if (mode == null) return;

                ref.read(themeProvider.notifier).setTheme(mode);
              },
            ),

            const SizedBox(height: 24),
            Text(
              'Стиль мапи',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<MapStyle>(
              initialValue: ref.watch(mapStyleProvider),
              items: MapStyle.values
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(mapStyleLabels[s]!),
                    ),
                  )
                  .toList(),
              onChanged: (style) {
                if (style == null) return;
                ref.read(mapStyleProvider.notifier).setStyle(style);
              },
            ),

            const SizedBox(height: 24),
            Text(
              'Одиниці',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<UnitSystem>(
              initialValue: ref.watch(unitsProvider),
              items: const [
                DropdownMenuItem(
                  value: UnitSystem.metric,
                  child: Text('Кілометри'),
                ),
                DropdownMenuItem(
                  value: UnitSystem.imperial,
                  child: Text('Милі'),
                ),
              ],
              onChanged: (units) {
                if (units == null) return;
                ref.read(unitsProvider.notifier).setUnits(units);
              },
            ),

            const SizedBox(height: 24),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Не вимикати екран під час запису',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Витрачає більше заряду батареї'),
              value: ref.watch(keepScreenOnProvider),
              onChanged: (enabled) {
                ref.read(keepScreenOnProvider.notifier).setEnabled(enabled);
              },
            ),
          ],
        ),
      ),
    );
  }
}
