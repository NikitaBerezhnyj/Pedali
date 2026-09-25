import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/providers.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.read(sharedPrefsProvider);
    final saved = prefs.getString('locale');

    if (saved != null) {
      return Locale(saved);
    }

    const supported = ['uk', 'en', 'es', 'fr'];

    final systemCode = PlatformDispatcher.instance.locale.languageCode;
    final resolved = supported.contains(systemCode) ? systemCode : 'en';

    prefs.setString('locale', resolved);

    return Locale(resolved);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = ref.read(sharedPrefsProvider);

    if (prefs.getString('locale') == locale.languageCode) {
      return;
    }

    await prefs.setString('locale', locale.languageCode);

    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
