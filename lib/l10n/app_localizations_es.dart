// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get themeLabel => 'Tema';

  @override
  String get systemThemeLabel => 'Sistema';

  @override
  String get lightThemeLabel => 'Claro';

  @override
  String get darkThemeLabel => 'Oscuro';

  @override
  String get mapStyleLabel => 'Estilo del mapa';

  @override
  String get unitsLabel => 'Unidades';

  @override
  String get kilometersLabel => 'Kilómetros';

  @override
  String get milesLabel => 'Millas';

  @override
  String get keepScreenOnLabel => 'Mantener la pantalla encendida durante la grabación';

  @override
  String get keepScreenOnDescription => 'Consume más batería';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get statsEmptyTitle => 'Vos records apparaîtront ici';

  @override
  String get statsEmptyDescription => 'Enregistrez votre première sortie pour commencer à suivre vos statistiques.';

  @override
  String get recordsTitle => 'Records';

  @override
  String get longestRideLabel => 'Sortie la plus longue';

  @override
  String get fastestRideLabel => 'Sortie la plus rapide';

  @override
  String get longestRideByTimeLabel => 'Sortie la plus longue en durée';

  @override
  String get monthlyStatsTitle => 'Par mois';

  @override
  String get monthlyStatsErrorTitle => 'Impossible de charger les statistiques';

  @override
  String get monthlyStatsEmpty => 'Aucune donnée pour le moment';

  @override
  String monthlyStatsSubtitle(int rideCount, String duration) {
    String _temp0 = intl.Intl.pluralLogic(
      rideCount,
      locale: localeName,
      other: '$rideCount sorties',
      one: '$rideCount sortie',
      zero: 'Aucune sortie',
    );
    return '$_temp0 • $duration';
  }

  @override
  String get shareRideTitle => 'Partager la sortie';

  @override
  String get shareButton => 'Partager';

  @override
  String get shareImageError => 'Impossible de préparer l’image';

  @override
  String get shareMovingTimeLabel => 'TEMPS EN MOUVEMENT';

  @override
  String get shareAvgSpeedLabel => 'VIT. MOYENNE';

  @override
  String get shareMaxSpeedLabel => 'VIT. MAXIMALE';

  @override
  String get finishRideTitle => 'Terminer la sortie ?';

  @override
  String get finishRideMessage => 'L’enregistrement s’arrêtera et la sortie sera enregistrée.';

  @override
  String get finishRideConfirm => 'Terminer';

  @override
  String get shortRideTitle => 'Sortie très courte';

  @override
  String get shortRideMessage => 'La sauvegarder quand même ?';

  @override
  String get saveRide => 'Enregistrer';

  @override
  String get discardRide => 'Supprimer';

  @override
  String get back => 'Retour';

  @override
  String get myLocation => 'Ma position';

  @override
  String get gpsUnstable => 'GPS instable — enregistrement en pause';

  @override
  String get gpsSearching => 'GPS : recherche du signal';

  @override
  String gpsAccuracy(int accuracy) {
    return 'GPS : ±$accuracy m';
  }

  @override
  String get finish => 'Terminer';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get distance => 'distance';

  @override
  String get movingTime => 'Temps en mouvement';

  @override
  String get elapsedTime => 'Temps total';

  @override
  String get averageSpeedShort => 'Vit. moyenne';

  @override
  String get maximumShort => 'Max.';

  @override
  String get deleteRideTitle => 'Supprimer la sortie ?';

  @override
  String get deleteRideMessage => 'La sortie et son itinéraire seront définitivement supprimés.';

  @override
  String get delete => 'Supprimer';

  @override
  String get rideDetailsTitle => 'Détails de la sortie';

  @override
  String get share => 'Partager';

  @override
  String get rideLoadError => 'Impossible de charger la sortie';

  @override
  String get rideNotFoundTitle => 'Sortie introuvable';

  @override
  String get rideNotFoundDescription => 'Elle a peut-être déjà été supprimée.';

  @override
  String get routeLoadError => 'Impossible de charger l’itinéraire';

  @override
  String get achievements => 'Succès';

  @override
  String get longestRideAchievement => 'Sortie la plus longue';

  @override
  String get highestAverageSpeedAchievement => 'Vitesse moyenne la plus élevée';

  @override
  String get longestMovingTimeAchievement => 'Temps en mouvement le plus long';

  @override
  String get stats => 'Statistiques';

  @override
  String get totalTime => 'Temps total';

  @override
  String get averageSpeed => 'Vitesse moyenne';

  @override
  String get maximumSpeed => 'Vitesse maximale';

  @override
  String get unfinishedRideTitle => 'Sortie inachevée';

  @override
  String unfinishedRideMessage(String ago, String distance) {
    return 'Il semble que l’application se soit fermée pendant l’enregistrement.\n\nCommencée il y a $ago · $distance\n\nVoulez-vous continuer cette sortie ou supprimer l’enregistrement ?';
  }

  @override
  String get continueLabel => 'Continuer';

  @override
  String startedDaysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count jours',
      one: 'il y a $count jour',
    );
    return '$_temp0';
  }

  @override
  String startedHoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count heures',
      one: 'il y a $count heure',
    );
    return '$_temp0';
  }

  @override
  String startedMinutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count minutes',
      one: 'il y a $count minute',
    );
    return '$_temp0';
  }

  @override
  String get startedJustNow => 'à l’instant';

  @override
  String get statistics => 'Statistiques';

  @override
  String get settings => 'Paramètres';

  @override
  String get rideListEmptyTitle => 'À vélo !';

  @override
  String get rideListEmptyDescription => 'Enregistrez votre première sortie et elle apparaîtra ici.';

  @override
  String get startRide => 'Commencer la sortie';

  @override
  String get routeNotVisibleTitle => 'La ruta aún no está disponible';

  @override
  String get routeNotVisibleDescription => 'No hay suficientes puntos GPS en esta salida para mostrar la ruta.';

  @override
  String get close => 'Cerrar';

  @override
  String get showFullRoute => 'Mostrar toda la ruta';

  @override
  String get tryAgainLater => 'Inténtalo de nuevo más tarde.';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ridesLoadError => 'No se pudieron cargar las salidas';

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
  String get mapStyleCycling => 'Ciclismo';

  @override
  String get mapStyleTerrain => 'Relieve';

  @override
  String get mapStyleSatellite => 'Satélite';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get achievementSectionRideDistance => 'Distancia en un recorrido';

  @override
  String get achievementSectionTotalDistance => 'Distancia total';

  @override
  String get achievementSectionRideCount => 'Número de recorridos';

  @override
  String get achievementSectionMaxSpeed => 'Velocidad máxima';

  @override
  String get achievementSectionRideDuration => 'Tiempo en movimiento por recorrido';

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
      other: '$count recorridos',
      one: '$count recorrido',
    );
    return '$_temp0';
  }

  @override
  String achievementDescRideDistance(Object n) {
    return 'Recorre $n km en un solo recorrido';
  }

  @override
  String achievementDescTotalDistance(Object n) {
    return 'Recorre $n km en total';
  }

  @override
  String achievementDescRideCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recorridos',
      one: '$count recorrido',
    );
    return 'Completa $_temp0';
  }

  @override
  String achievementDescMaxSpeed(Object n) {
    return 'Alcanza los $n km/h';
  }

  @override
  String achievementDescRideDuration(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '$count hora',
    );
    return 'Pedalea durante $_temp0 en un solo recorrido';
  }

  @override
  String achievementProgress(Object current, Object target) {
    return '$current / $target';
  }

  @override
  String get achievementCompleted => 'Completado';

  @override
  String get shareAchievementTitle => 'Compartir logro';

  @override
  String get recordLongestDistance => 'Más larga por distancia';

  @override
  String get recordLongestTime => 'Más larga por tiempo';

  @override
  String get recordHighestAvgSpeed => 'Mayor velocidad media';

  @override
  String get recordHighestMaxSpeed => 'Mayor velocidad máxima';

  @override
  String get continueRide => 'Continuar recorrido';

  @override
  String get rideInProgress => 'Recorrido en curso';

  @override
  String get ridePaused => 'Recorrido en pausa';

  @override
  String get recordingNotificationText => 'Grabando tu recorrido';

  @override
  String get locationAccessError => 'Sin acceso a la ubicación. Revisa el permiso y que la ubicación esté activada.';

  @override
  String get achievementUnlocked => 'Nuevo logro';

  @override
  String get viewAllAchievements => 'Todos los logros';
}
