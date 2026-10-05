import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/features/map/domain/map_style.dart';
import 'package:pedali/features/settings/providers/keep_screen_on_provider.dart';
import 'package:pedali/features/settings/providers/locale_provider.dart';
import 'package:pedali/features/settings/providers/theme_provider.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/map/providers/map_style_provider.dart';
import 'package:pedali/features/settings/widgets/setting_dropdown.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';

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
    final mapStyle = ref.watch(mapStyleProvider);
    final units = ref.watch(unitsProvider);
    final keepScreenOn = ref.watch(keepScreenOnProvider);

    final selectedLanguage = supportedLocales.entries
        .firstWhere(
          (entry) => entry.value.languageCode == locale.languageCode,
          orElse: () => supportedLocales.entries.first,
        )
        .key;

    return Scaffold(
      appBar: AppHeader(title: t.settingsTitle, showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsDropdown<String>(
              label: t.languageLabel,
              value: selectedLanguage,
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
            const SizedBox(height: AppSpacing.lg),
            SettingsDropdown<ThemeMode>(
              label: t.themeLabel,
              value: theme,
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
            const SizedBox(height: AppSpacing.lg),
            SettingsDropdown<MapStyle>(
              label: t.mapStyleLabel,
              value: mapStyle,
              items: MapStyle.values
                  .map(
                    (style) => DropdownMenuItem(
                      value: style,
                      child: Text(switch (style) {
                        MapStyle.cycling => t.mapStyleCycling,
                        MapStyle.terrain => t.mapStyleTerrain,
                        MapStyle.satellite => t.mapStyleSatellite,
                      }),
                    ),
                  )
                  .toList(),
              onChanged: (style) {
                if (style == null) return;

                ref.read(mapStyleProvider.notifier).setStyle(style);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            SettingsDropdown<UnitSystem>(
              label: t.unitsLabel,
              value: units,
              items: [
                DropdownMenuItem(
                  value: UnitSystem.metric,
                  child: Text(t.kilometersLabel),
                ),
                DropdownMenuItem(
                  value: UnitSystem.imperial,
                  child: Text(t.milesLabel),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                ref.read(unitsProvider.notifier).setUnits(value);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                t.keepScreenOnLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(t.keepScreenOnDescription),
              value: keepScreenOn,
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
