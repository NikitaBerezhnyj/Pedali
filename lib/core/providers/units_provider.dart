import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/providers/shared_prefs_provider.dart';
import 'package:pedali/core/utils/units.dart';

class UnitsNotifier extends Notifier<UnitSystem> {
  @override
  UnitSystem build() {
    final prefs = ref.read(sharedPrefsProvider);
    final saved = prefs.getString('units');
    return UnitSystem.values.firstWhere(
      (u) => u.name == saved,
      orElse: () => UnitSystem.metric,
    );
  }

  Future<void> setUnits(UnitSystem units) async {
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setString('units', units.name);
    state = units;
  }
}

final unitsProvider = NotifierProvider<UnitsNotifier, UnitSystem>(
  UnitsNotifier.new,
);
