import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/providers/locale_provider.dart';
import 'package:pedali/core/providers/shared_prefs_provider.dart';
import 'package:pedali/core/providers/theme_provider.dart';
import 'package:pedali/features/splash/initial_screen.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const PedaliApp(),
    ),
  );
}

class PedaliApp extends ConsumerWidget {
  const PedaliApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Pedali',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
        brightness: Brightness.dark,
      ),

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
