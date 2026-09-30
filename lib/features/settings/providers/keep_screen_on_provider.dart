import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/providers/shared_prefs_provider.dart';

class KeepScreenOnNotifier extends Notifier<bool> {
  static const _key = 'keep_screen_on';

  @override
  bool build() {
    final prefs = ref.read(sharedPrefsProvider);
    return prefs.getBool(_key) ?? false;
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setBool(_key, enabled);
    state = enabled;
  }
}

final keepScreenOnProvider = NotifierProvider<KeepScreenOnNotifier, bool>(
  KeepScreenOnNotifier.new,
);
