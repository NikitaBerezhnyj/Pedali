import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('uk')
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @systemThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemThemeLabel;

  /// No description provided for @lightThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightThemeLabel;

  /// No description provided for @darkThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkThemeLabel;

  /// No description provided for @mapStyleLabel.
  ///
  /// In en, this message translates to:
  /// **'Map style'**
  String get mapStyleLabel;

  /// No description provided for @unitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitsLabel;

  /// No description provided for @kilometersLabel.
  ///
  /// In en, this message translates to:
  /// **'Kilometers'**
  String get kilometersLabel;

  /// No description provided for @milesLabel.
  ///
  /// In en, this message translates to:
  /// **'Miles'**
  String get milesLabel;

  /// No description provided for @keepScreenOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Keep screen on while recording'**
  String get keepScreenOnLabel;

  /// No description provided for @keepScreenOnDescription.
  ///
  /// In en, this message translates to:
  /// **'Uses more battery power'**
  String get keepScreenOnDescription;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @statsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your records will appear here'**
  String get statsEmptyTitle;

  /// No description provided for @statsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Record your first ride to start tracking your stats.'**
  String get statsEmptyDescription;

  /// No description provided for @recordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get recordsTitle;

  /// No description provided for @longestRideLabel.
  ///
  /// In en, this message translates to:
  /// **'Longest ride'**
  String get longestRideLabel;

  /// No description provided for @fastestRideLabel.
  ///
  /// In en, this message translates to:
  /// **'Fastest ride'**
  String get fastestRideLabel;

  /// No description provided for @longestRideByTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Longest ride by duration'**
  String get longestRideByTimeLabel;

  /// No description provided for @monthlyStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'By month'**
  String get monthlyStatsTitle;

  /// No description provided for @monthlyStatsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load statistics'**
  String get monthlyStatsErrorTitle;

  /// No description provided for @monthlyStatsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get monthlyStatsEmpty;

  /// No description provided for @monthlyStatsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{rideCount, plural, =0{No rides} one{{rideCount} ride} other{{rideCount} rides}} • {duration}'**
  String monthlyStatsSubtitle(int rideCount, String duration);

  /// No description provided for @shareRideTitle.
  ///
  /// In en, this message translates to:
  /// **'Share ride'**
  String get shareRideTitle;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareButton;

  /// No description provided for @shareImageError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t prepare the image'**
  String get shareImageError;

  /// No description provided for @shareMovingTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'MOVING TIME'**
  String get shareMovingTimeLabel;

  /// No description provided for @shareAvgSpeedLabel.
  ///
  /// In en, this message translates to:
  /// **'AVG. SPEED'**
  String get shareAvgSpeedLabel;

  /// No description provided for @shareMaxSpeedLabel.
  ///
  /// In en, this message translates to:
  /// **'MAX. SPEED'**
  String get shareMaxSpeedLabel;

  /// No description provided for @finishRideTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish ride?'**
  String get finishRideTitle;

  /// No description provided for @finishRideMessage.
  ///
  /// In en, this message translates to:
  /// **'Recording will stop and the ride will be saved.'**
  String get finishRideMessage;

  /// No description provided for @finishRideConfirm.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishRideConfirm;

  /// No description provided for @shortRideTitle.
  ///
  /// In en, this message translates to:
  /// **'Very short ride'**
  String get shortRideTitle;

  /// No description provided for @shortRideMessage.
  ///
  /// In en, this message translates to:
  /// **'Save it anyway?'**
  String get shortRideMessage;

  /// No description provided for @saveRide.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveRide;

  /// No description provided for @discardRide.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get discardRide;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @myLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get myLocation;

  /// No description provided for @gpsUnstable.
  ///
  /// In en, this message translates to:
  /// **'GPS is unstable — recording paused'**
  String get gpsUnstable;

  /// No description provided for @gpsSearching.
  ///
  /// In en, this message translates to:
  /// **'GPS: searching for signal'**
  String get gpsSearching;

  /// No description provided for @gpsAccuracy.
  ///
  /// In en, this message translates to:
  /// **'GPS: ±{accuracy} m'**
  String gpsAccuracy(int accuracy);

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'distance'**
  String get distance;

  /// No description provided for @movingTime.
  ///
  /// In en, this message translates to:
  /// **'Moving time'**
  String get movingTime;

  /// No description provided for @elapsedTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get elapsedTime;

  /// No description provided for @averageSpeedShort.
  ///
  /// In en, this message translates to:
  /// **'Avg. speed'**
  String get averageSpeedShort;

  /// No description provided for @maximumShort.
  ///
  /// In en, this message translates to:
  /// **'Max.'**
  String get maximumShort;

  /// No description provided for @deleteRideTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete ride?'**
  String get deleteRideTitle;

  /// No description provided for @deleteRideMessage.
  ///
  /// In en, this message translates to:
  /// **'The ride and its route will be permanently deleted.'**
  String get deleteRideMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @rideDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ride details'**
  String get rideDetailsTitle;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @rideLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the ride'**
  String get rideLoadError;

  /// No description provided for @rideNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Ride not found'**
  String get rideNotFoundTitle;

  /// No description provided for @rideNotFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'It may have already been deleted.'**
  String get rideNotFoundDescription;

  /// No description provided for @routeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the route'**
  String get routeLoadError;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @longestRideAchievement.
  ///
  /// In en, this message translates to:
  /// **'Longest ride'**
  String get longestRideAchievement;

  /// No description provided for @highestAverageSpeedAchievement.
  ///
  /// In en, this message translates to:
  /// **'Highest average speed'**
  String get highestAverageSpeedAchievement;

  /// No description provided for @longestMovingTimeAchievement.
  ///
  /// In en, this message translates to:
  /// **'Longest moving time'**
  String get longestMovingTimeAchievement;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get totalTime;

  /// No description provided for @averageSpeed.
  ///
  /// In en, this message translates to:
  /// **'Average speed'**
  String get averageSpeed;

  /// No description provided for @maximumSpeed.
  ///
  /// In en, this message translates to:
  /// **'Maximum speed'**
  String get maximumSpeed;

  /// No description provided for @unfinishedRideTitle.
  ///
  /// In en, this message translates to:
  /// **'Unfinished ride'**
  String get unfinishedRideTitle;

  /// No description provided for @unfinishedRideMessage.
  ///
  /// In en, this message translates to:
  /// **'It looks like the app closed while recording.\n\nStarted {ago} ago · {distance}\n\nWould you like to continue this ride or delete the recording?'**
  String unfinishedRideMessage(String ago, String distance);

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @startedDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String startedDaysAgo(num count);

  /// No description provided for @startedHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour} other{{count} hours}}'**
  String startedHoursAgo(num count);

  /// No description provided for @startedMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} minute} other{{count} minutes}}'**
  String startedMinutesAgo(num count);

  /// No description provided for @startedJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get startedJustNow;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @rideListEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to ride'**
  String get rideListEmptyTitle;

  /// No description provided for @rideListEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Record your first ride and it will appear here.'**
  String get rideListEmptyDescription;

  /// No description provided for @startRide.
  ///
  /// In en, this message translates to:
  /// **'Start ride'**
  String get startRide;

  /// No description provided for @routeNotVisibleTitle.
  ///
  /// In en, this message translates to:
  /// **'Route not available yet'**
  String get routeNotVisibleTitle;

  /// No description provided for @routeNotVisibleDescription.
  ///
  /// In en, this message translates to:
  /// **'There aren\'t enough GPS points in this ride to display the route.'**
  String get routeNotVisibleDescription;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @showFullRoute.
  ///
  /// In en, this message translates to:
  /// **'Show full route'**
  String get showFullRoute;

  /// No description provided for @tryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later.'**
  String get tryAgainLater;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ridesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load rides'**
  String get ridesLoadError;

  /// No description provided for @hourShort.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hourShort;

  /// No description provided for @minuteShort.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get minuteShort;

  /// No description provided for @secondShort.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get secondShort;

  /// No description provided for @kilometerUnit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get kilometerUnit;

  /// No description provided for @mileUnit.
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get mileUnit;

  /// No description provided for @kilometersPerHourUnit.
  ///
  /// In en, this message translates to:
  /// **'km/h'**
  String get kilometersPerHourUnit;

  /// No description provided for @milesPerHourUnit.
  ///
  /// In en, this message translates to:
  /// **'mph'**
  String get milesPerHourUnit;

  /// No description provided for @mapStyleCycling.
  ///
  /// In en, this message translates to:
  /// **'Cycling'**
  String get mapStyleCycling;

  /// No description provided for @mapStyleTerrain.
  ///
  /// In en, this message translates to:
  /// **'Terrain'**
  String get mapStyleTerrain;

  /// No description provided for @mapStyleSatellite.
  ///
  /// In en, this message translates to:
  /// **'Satellite'**
  String get mapStyleSatellite;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementSectionRideDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance in one ride'**
  String get achievementSectionRideDistance;

  /// No description provided for @achievementSectionTotalDistance.
  ///
  /// In en, this message translates to:
  /// **'Total distance'**
  String get achievementSectionTotalDistance;

  /// No description provided for @achievementSectionRideCount.
  ///
  /// In en, this message translates to:
  /// **'Number of rides'**
  String get achievementSectionRideCount;

  /// No description provided for @achievementSectionMaxSpeed.
  ///
  /// In en, this message translates to:
  /// **'Top speed'**
  String get achievementSectionMaxSpeed;

  /// No description provided for @achievementSectionRideDuration.
  ///
  /// In en, this message translates to:
  /// **'Moving time in one ride'**
  String get achievementSectionRideDuration;

  /// No description provided for @achievementLabelKm.
  ///
  /// In en, this message translates to:
  /// **'{n} km'**
  String achievementLabelKm(Object n);

  /// No description provided for @achievementLabelKmh.
  ///
  /// In en, this message translates to:
  /// **'{n} km/h'**
  String achievementLabelKmh(Object n);

  /// No description provided for @achievementLabelHours.
  ///
  /// In en, this message translates to:
  /// **'{n} h'**
  String achievementLabelHours(Object n);

  /// No description provided for @achievementLabelRides.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} ride} other{{count} rides}}'**
  String achievementLabelRides(num count);

  /// No description provided for @achievementDescRideDistance.
  ///
  /// In en, this message translates to:
  /// **'Cover {n} km in a single ride'**
  String achievementDescRideDistance(Object n);

  /// No description provided for @achievementDescTotalDistance.
  ///
  /// In en, this message translates to:
  /// **'Cover {n} km in total'**
  String achievementDescTotalDistance(Object n);

  /// No description provided for @achievementDescRideCount.
  ///
  /// In en, this message translates to:
  /// **'Complete {count, plural, one{{count} ride} other{{count} rides}}'**
  String achievementDescRideCount(num count);

  /// No description provided for @achievementDescMaxSpeed.
  ///
  /// In en, this message translates to:
  /// **'Reach {n} km/h'**
  String achievementDescMaxSpeed(Object n);

  /// No description provided for @achievementDescRideDuration.
  ///
  /// In en, this message translates to:
  /// **'Keep moving for {count, plural, one{{count} hour} other{{count} hours}} in a single ride'**
  String achievementDescRideDuration(num count);

  /// No description provided for @achievementProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {target}'**
  String achievementProgress(Object current, Object target);

  /// No description provided for @achievementCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get achievementCompleted;

  /// No description provided for @shareAchievementTitle.
  ///
  /// In en, this message translates to:
  /// **'Share achievement'**
  String get shareAchievementTitle;

  /// No description provided for @recordLongestDistance.
  ///
  /// In en, this message translates to:
  /// **'Longest by distance'**
  String get recordLongestDistance;

  /// No description provided for @recordLongestTime.
  ///
  /// In en, this message translates to:
  /// **'Longest by time'**
  String get recordLongestTime;

  /// No description provided for @recordHighestAvgSpeed.
  ///
  /// In en, this message translates to:
  /// **'Highest average speed'**
  String get recordHighestAvgSpeed;

  /// No description provided for @recordHighestMaxSpeed.
  ///
  /// In en, this message translates to:
  /// **'Highest max speed'**
  String get recordHighestMaxSpeed;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
