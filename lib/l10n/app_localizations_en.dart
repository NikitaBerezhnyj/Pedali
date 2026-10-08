// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get themeLabel => 'Theme';

  @override
  String get systemThemeLabel => 'System';

  @override
  String get lightThemeLabel => 'Light';

  @override
  String get darkThemeLabel => 'Dark';

  @override
  String get mapStyleLabel => 'Map style';

  @override
  String get unitsLabel => 'Units';

  @override
  String get kilometersLabel => 'Kilometers';

  @override
  String get milesLabel => 'Miles';

  @override
  String get keepScreenOnLabel => 'Keep screen on while recording';

  @override
  String get keepScreenOnDescription => 'Uses more battery power';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsEmptyTitle => 'Your records will appear here';

  @override
  String get statsEmptyDescription => 'Record your first ride to start tracking your stats.';

  @override
  String get recordsTitle => 'Records';

  @override
  String get longestRideLabel => 'Longest ride';

  @override
  String get fastestRideLabel => 'Fastest ride';

  @override
  String get longestRideByTimeLabel => 'Longest ride by duration';

  @override
  String get monthlyStatsTitle => 'By month';

  @override
  String get monthlyStatsErrorTitle => 'Couldn\'t load statistics';

  @override
  String get monthlyStatsEmpty => 'No data yet';

  @override
  String monthlyStatsSubtitle(int rideCount, String duration) {
    String _temp0 = intl.Intl.pluralLogic(
      rideCount,
      locale: localeName,
      other: '$rideCount rides',
      one: '$rideCount ride',
      zero: 'No rides',
    );
    return '$_temp0 • $duration';
  }

  @override
  String get shareRideTitle => 'Share ride';

  @override
  String get shareButton => 'Share';

  @override
  String get shareImageError => 'Couldn\'t prepare the image';

  @override
  String get shareMovingTimeLabel => 'MOVING TIME';

  @override
  String get shareAvgSpeedLabel => 'AVG. SPEED';

  @override
  String get shareMaxSpeedLabel => 'MAX. SPEED';

  @override
  String get finishRideTitle => 'Finish ride?';

  @override
  String get finishRideMessage => 'Recording will stop and the ride will be saved.';

  @override
  String get finishRideConfirm => 'Finish';

  @override
  String get shortRideTitle => 'Very short ride';

  @override
  String get shortRideMessage => 'Save it anyway?';

  @override
  String get saveRide => 'Save';

  @override
  String get discardRide => 'Delete';

  @override
  String get back => 'Back';

  @override
  String get myLocation => 'My location';

  @override
  String get gpsUnstable => 'GPS is unstable — recording paused';

  @override
  String get gpsSearching => 'GPS: searching for signal';

  @override
  String gpsAccuracy(int accuracy) {
    return 'GPS: ±$accuracy m';
  }

  @override
  String get finish => 'Finish';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get distance => 'distance';

  @override
  String get movingTime => 'Moving time';

  @override
  String get elapsedTime => 'Total time';

  @override
  String get averageSpeedShort => 'Avg. speed';

  @override
  String get maximumShort => 'Max.';

  @override
  String get deleteRideTitle => 'Delete ride?';

  @override
  String get deleteRideMessage => 'The ride and its route will be permanently deleted.';

  @override
  String get delete => 'Delete';

  @override
  String get rideDetailsTitle => 'Ride details';

  @override
  String get share => 'Share';

  @override
  String get rideLoadError => 'Couldn\'t load the ride';

  @override
  String get rideNotFoundTitle => 'Ride not found';

  @override
  String get rideNotFoundDescription => 'It may have already been deleted.';

  @override
  String get routeLoadError => 'Couldn\'t load the route';

  @override
  String get achievements => 'Achievements';

  @override
  String get longestRideAchievement => 'Longest ride';

  @override
  String get highestAverageSpeedAchievement => 'Highest average speed';

  @override
  String get longestMovingTimeAchievement => 'Longest moving time';

  @override
  String get stats => 'Statistics';

  @override
  String get totalTime => 'Total time';

  @override
  String get averageSpeed => 'Average speed';

  @override
  String get maximumSpeed => 'Maximum speed';

  @override
  String get unfinishedRideTitle => 'Unfinished ride';

  @override
  String unfinishedRideMessage(String ago, String distance) {
    return 'It looks like the app closed while recording.\n\nStarted $ago ago · $distance\n\nWould you like to continue this ride or delete the recording?';
  }

  @override
  String get continueLabel => 'Continue';

  @override
  String startedDaysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String startedHoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '$count hour',
    );
    return '$_temp0';
  }

  @override
  String startedMinutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '$count minute',
    );
    return '$_temp0';
  }

  @override
  String get startedJustNow => 'just now';

  @override
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get rideListEmptyTitle => 'Time to ride';

  @override
  String get rideListEmptyDescription => 'Record your first ride and it will appear here.';

  @override
  String get startRide => 'Start ride';

  @override
  String get routeNotVisibleTitle => 'Route not available yet';

  @override
  String get routeNotVisibleDescription => 'There aren\'t enough GPS points in this ride to display the route.';

  @override
  String get close => 'Close';

  @override
  String get showFullRoute => 'Show full route';

  @override
  String get tryAgainLater => 'Please try again later.';

  @override
  String get tryAgain => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get ridesLoadError => 'Couldn\'t load rides';

  @override
  String get hourShort => 'h';

  @override
  String get minuteShort => 'm';

  @override
  String get secondShort => 's';

  @override
  String get kilometerUnit => 'km';

  @override
  String get mileUnit => 'mi';

  @override
  String get kilometersPerHourUnit => 'km/h';

  @override
  String get milesPerHourUnit => 'mph';

  @override
  String get mapStyleCycling => 'Cycling';

  @override
  String get mapStyleTerrain => 'Terrain';

  @override
  String get mapStyleSatellite => 'Satellite';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get achievementSectionRideDistance => 'Distance in one ride';

  @override
  String get achievementSectionTotalDistance => 'Total distance';

  @override
  String get achievementSectionRideCount => 'Number of rides';

  @override
  String get achievementSectionMaxSpeed => 'Top speed';

  @override
  String get achievementSectionRideDuration => 'Moving time in one ride';

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
      other: '$count rides',
      one: '$count ride',
    );
    return '$_temp0';
  }

  @override
  String achievementDescRideDistance(Object n) {
    return 'Cover $n km in a single ride';
  }

  @override
  String achievementDescTotalDistance(Object n) {
    return 'Cover $n km in total';
  }

  @override
  String achievementDescRideCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rides',
      one: '$count ride',
    );
    return 'Complete $_temp0';
  }

  @override
  String achievementDescMaxSpeed(Object n) {
    return 'Reach $n km/h';
  }

  @override
  String achievementDescRideDuration(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '$count hour',
    );
    return 'Keep moving for $_temp0 in a single ride';
  }

  @override
  String achievementProgress(Object current, Object target) {
    return '$current / $target';
  }

  @override
  String get achievementCompleted => 'Completed';

  @override
  String get shareAchievementTitle => 'Share achievement';

  @override
  String get recordLongestDistance => 'Longest by distance';

  @override
  String get recordLongestTime => 'Longest by time';

  @override
  String get recordHighestAvgSpeed => 'Highest average speed';

  @override
  String get recordHighestMaxSpeed => 'Highest max speed';

  @override
  String get continueRide => 'Continue ride';

  @override
  String get rideInProgress => 'Ride in progress';

  @override
  String get ridePaused => 'Ride paused';
}
