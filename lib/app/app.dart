import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/app/app_theme.dart';
import 'package:pedali/app/initial_screen.dart';
import 'package:pedali/features/settings/providers/locale_provider.dart';
import 'package:pedali/features/settings/providers/theme_provider.dart';
import 'package:pedali/l10n/app_localizations.dart';

class PedaliApp extends ConsumerWidget {
  const PedaliApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Pedali',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
        Locale('es'),
        Locale('fr'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const InitialScreen(),
    );
  }
}
