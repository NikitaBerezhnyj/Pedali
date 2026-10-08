// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get languageLabel => 'Langue';

  @override
  String get themeLabel => 'Thème';

  @override
  String get systemThemeLabel => 'Système';

  @override
  String get lightThemeLabel => 'Clair';

  @override
  String get darkThemeLabel => 'Sombre';

  @override
  String get mapStyleLabel => 'Style de carte';

  @override
  String get unitsLabel => 'Unités';

  @override
  String get kilometersLabel => 'Kilomètres';

  @override
  String get milesLabel => 'Milles';

  @override
  String get keepScreenOnLabel => 'Garder l’écran allumé pendant l’enregistrement';

  @override
  String get keepScreenOnDescription => 'Consomme davantage de batterie';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsEmptyTitle => 'Tus récords aparecerán aquí';

  @override
  String get statsEmptyDescription => 'Registra tu primera salida para empezar a consultar tus estadísticas.';

  @override
  String get recordsTitle => 'Récords';

  @override
  String get longestRideLabel => 'Salida más larga';

  @override
  String get fastestRideLabel => 'Salida más rápida';

  @override
  String get longestRideByTimeLabel => 'Salida de mayor duración';

  @override
  String get monthlyStatsTitle => 'Por mes';

  @override
  String get monthlyStatsErrorTitle => 'No se pudieron cargar las estadísticas';

  @override
  String get monthlyStatsEmpty => 'Todavía no hay datos';

  @override
  String monthlyStatsSubtitle(int rideCount, String duration) {
    String _temp0 = intl.Intl.pluralLogic(
      rideCount,
      locale: localeName,
      other: '$rideCount salidas',
      one: '$rideCount salida',
      zero: 'Ninguna salida',
    );
    return '$_temp0 • $duration';
  }

  @override
  String get shareRideTitle => 'Compartir salida';

  @override
  String get shareButton => 'Compartir';

  @override
  String get shareImageError => 'No se pudo preparar la imagen';

  @override
  String get shareMovingTimeLabel => 'TIEMPO EN MOVIMIENTO';

  @override
  String get shareAvgSpeedLabel => 'VEL. MEDIA';

  @override
  String get shareMaxSpeedLabel => 'VEL. MÁXIMA';

  @override
  String get finishRideTitle => '¿Finalizar salida?';

  @override
  String get finishRideMessage => 'La grabación se detendrá y la salida se guardará.';

  @override
  String get finishRideConfirm => 'Finalizar';

  @override
  String get shortRideTitle => 'Salida muy corta';

  @override
  String get shortRideMessage => '¿Guardarla de todos modos?';

  @override
  String get saveRide => 'Guardar';

  @override
  String get discardRide => 'Eliminar';

  @override
  String get back => 'Atrás';

  @override
  String get myLocation => 'Mi ubicación';

  @override
  String get gpsUnstable => 'El GPS es inestable — grabación en pausa';

  @override
  String get gpsSearching => 'GPS: buscando señal';

  @override
  String gpsAccuracy(int accuracy) {
    return 'GPS: ±$accuracy m';
  }

  @override
  String get finish => 'Finalizar';

  @override
  String get pause => 'Pausa';

  @override
  String get resume => 'Continuar';

  @override
  String get distance => 'distancia';

  @override
  String get movingTime => 'Tiempo en movimiento';

  @override
  String get elapsedTime => 'Tiempo total';

  @override
  String get averageSpeedShort => 'Vel. media';

  @override
  String get maximumShort => 'Máx.';

  @override
  String get deleteRideTitle => '¿Eliminar salida?';

  @override
  String get deleteRideMessage => 'La salida y su ruta se eliminarán permanentemente.';

  @override
  String get delete => 'Eliminar';

  @override
  String get rideDetailsTitle => 'Detalles de la salida';

  @override
  String get share => 'Compartir';

  @override
  String get rideLoadError => 'No se pudo cargar la salida';

  @override
  String get rideNotFoundTitle => 'Salida no encontrada';

  @override
  String get rideNotFoundDescription => 'Es posible que ya haya sido eliminada.';

  @override
  String get routeLoadError => 'No se pudo cargar la ruta';

  @override
  String get achievements => 'Logros';

  @override
  String get longestRideAchievement => 'Salida más larga';

  @override
  String get highestAverageSpeedAchievement => 'Mayor velocidad media';

  @override
  String get longestMovingTimeAchievement => 'Mayor tiempo en movimiento';

  @override
  String get stats => 'Estadísticas';

  @override
  String get totalTime => 'Tiempo total';

  @override
  String get averageSpeed => 'Velocidad media';

  @override
  String get maximumSpeed => 'Velocidad máxima';

  @override
  String get unfinishedRideTitle => 'Salida sin terminar';

  @override
  String unfinishedRideMessage(String ago, String distance) {
    return 'Parece que la aplicación se cerró durante la grabación.\n\nIniciada hace $ago · $distance\n\n¿Quieres continuar esta salida o eliminar la grabación?';
  }

  @override
  String get continueLabel => 'Continuar';

  @override
  String startedDaysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count días',
      one: 'hace $count día',
    );
    return '$_temp0';
  }

  @override
  String startedHoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count horas',
      one: 'hace $count hora',
    );
    return '$_temp0';
  }

  @override
  String startedMinutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count minutos',
      one: 'hace $count minuto',
    );
    return '$_temp0';
  }

  @override
  String get startedJustNow => 'justo ahora';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get settings => 'Ajustes';

  @override
  String get rideListEmptyTitle => 'Hora de salir';

  @override
  String get rideListEmptyDescription => 'Registra tu primera salida y aparecerá aquí.';

  @override
  String get startRide => 'Comenzar salida';

  @override
  String get routeNotVisibleTitle => 'Itinéraire indisponible';

  @override
  String get routeNotVisibleDescription => 'Il n’y a pas assez de points GPS dans cette sortie pour afficher l’itinéraire.';

  @override
  String get close => 'Fermer';

  @override
  String get showFullRoute => 'Afficher tout l’itinéraire';

  @override
  String get tryAgainLater => 'Réessayez un peu plus tard.';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get cancel => 'Annuler';

  @override
  String get ridesLoadError => 'Impossible de charger les sorties';

  @override
  String get hourShort => ' h';

  @override
  String get minuteShort => ' min';

  @override
  String get secondShort => ' s';

  @override
  String get kilometerUnit => 'km';

  @override
  String get mileUnit => 'mi';

  @override
  String get kilometersPerHourUnit => 'km/h';

  @override
  String get milesPerHourUnit => 'mph';

  @override
  String get mapStyleCycling => 'Vélo';

  @override
  String get mapStyleTerrain => 'Relief';

  @override
  String get mapStyleSatellite => 'Satellite';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String get achievementSectionRideDistance => 'Distance par sortie';

  @override
  String get achievementSectionTotalDistance => 'Distance totale';

  @override
  String get achievementSectionRideCount => 'Nombre de sorties';

  @override
  String get achievementSectionMaxSpeed => 'Vitesse maximale';

  @override
  String get achievementSectionRideDuration => 'Temps en mouvement par sortie';

  @override
  String achievementLabelKm(Object n) {
    return '$n km';
  }

  @override
  String achievementLabelKmh(Object n) {
    return '$n km/h';
  }

  @override
  String achievementLabelHours(Object n) {
    return '$n h';
  }

  @override
  String achievementLabelRides(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sorties',
      one: '$count sortie',
    );
    return '$_temp0';
  }

  @override
  String achievementDescRideDistance(Object n) {
    return 'Parcourez $n km en une seule sortie';
  }

  @override
  String achievementDescTotalDistance(Object n) {
    return 'Parcourez $n km au total';
  }

  @override
  String achievementDescRideCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sorties',
      one: '$count sortie',
    );
    return 'Terminez $_temp0';
  }

  @override
  String achievementDescMaxSpeed(Object n) {
    return 'Atteignez $n km/h';
  }

  @override
  String achievementDescRideDuration(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      one: '$count heure',
    );
    return 'Roulez pendant $_temp0 en une seule sortie';
  }

  @override
  String achievementProgress(Object current, Object target) {
    return '$current / $target';
  }

  @override
  String get achievementCompleted => 'Accompli';

  @override
  String get shareAchievementTitle => 'Partager le succès';

  @override
  String get recordLongestDistance => 'Plus longue en distance';

  @override
  String get recordLongestTime => 'Plus longue en durée';

  @override
  String get recordHighestAvgSpeed => 'Vitesse moyenne la plus élevée';

  @override
  String get recordHighestMaxSpeed => 'Vitesse maximale la plus élevée';

  @override
  String get continueRide => 'Reprendre la sortie';

  @override
  String get rideInProgress => 'Sortie en cours';

  @override
  String get ridePaused => 'Sortie en pause';

  @override
  String get recordingNotificationText => 'Enregistrement de la sortie';

  @override
  String get locationAccessError => 'Accès à la position impossible. Vérifiez la permission et que la localisation est activée.';

  @override
  String get achievementUnlocked => 'Nouveau succès';

  @override
  String get viewAllAchievements => 'Tous les succès';
}
