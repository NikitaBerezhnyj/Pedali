// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get languageLabel => 'Мова';

  @override
  String get themeLabel => 'Тема';

  @override
  String get systemThemeLabel => 'Системна';

  @override
  String get lightThemeLabel => 'Світла';

  @override
  String get darkThemeLabel => 'Темна';

  @override
  String get mapStyleLabel => 'Стиль мапи';

  @override
  String get unitsLabel => 'Одиниці вимірювання';

  @override
  String get kilometersLabel => 'Кілометри';

  @override
  String get milesLabel => 'Милі';

  @override
  String get keepScreenOnLabel => 'Не вимикати екран під час запису';

  @override
  String get keepScreenOnDescription => 'Збільшує витрату заряду батареї';

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsEmptyTitle => 'Тут будуть твої рекорди';

  @override
  String get statsEmptyDescription => 'Запиши свою першу поїздку, щоб почати збирати статистику.';

  @override
  String get recordsTitle => 'Рекорди';

  @override
  String get longestRideLabel => 'Найдовша поїздка';

  @override
  String get fastestRideLabel => 'Найшвидша поїздка';

  @override
  String get longestRideByTimeLabel => 'Найдовша за часом';

  @override
  String get monthlyStatsTitle => 'По місяцях';

  @override
  String get monthlyStatsErrorTitle => 'Не вдалося завантажити статистику';

  @override
  String get monthlyStatsEmpty => 'Поки немає даних';

  @override
  String monthlyStatsSubtitle(int rideCount, String duration) {
    String _temp0 = intl.Intl.pluralLogic(
      rideCount,
      locale: localeName,
      other: '$rideCount поїздки',
      many: '$rideCount поїздок',
      few: '$rideCount поїздки',
      one: '$rideCount поїздка',
    );
    return '$_temp0 • $duration';
  }

  @override
  String get shareRideTitle => 'Поділитися поїздкою';

  @override
  String get shareButton => 'Поділитися';

  @override
  String get shareImageError => 'Не вдалося підготувати зображення';

  @override
  String get shareMovingTimeLabel => 'ЧАС У РУСІ';

  @override
  String get shareAvgSpeedLabel => 'СЕР. ШВИДКІСТЬ';

  @override
  String get shareMaxSpeedLabel => 'МАКС. ШВИДКІСТЬ';

  @override
  String get finishRideTitle => 'Завершити поїздку?';

  @override
  String get finishRideMessage => 'Запис зупиниться і поїздку буде збережено.';

  @override
  String get finishRideConfirm => 'Завершити';

  @override
  String get shortRideTitle => 'Дуже коротка поїздка';

  @override
  String get shortRideMessage => 'Зберегти її все одно?';

  @override
  String get saveRide => 'Зберегти';

  @override
  String get discardRide => 'Видалити';

  @override
  String get back => 'Назад';

  @override
  String get myLocation => 'До моєї позиції';

  @override
  String get gpsUnstable => 'GPS нестабільний — запис призупинено';

  @override
  String get gpsSearching => 'GPS: пошук сигналу';

  @override
  String gpsAccuracy(int accuracy) {
    return 'GPS: ±$accuracy м';
  }

  @override
  String get finish => 'Завершити';

  @override
  String get pause => 'Пауза';

  @override
  String get resume => 'Продовжити';

  @override
  String get distance => 'дистанція';

  @override
  String get movingTime => 'Час у русі';

  @override
  String get elapsedTime => 'Заг. час';

  @override
  String get averageSpeedShort => 'Сер. швидк.';

  @override
  String get maximumShort => 'Макс.';

  @override
  String get deleteRideTitle => 'Видалити поїздку?';

  @override
  String get deleteRideMessage => 'Поїздку разом із маршрутом буде видалено назавжди.';

  @override
  String get delete => 'Видалити';

  @override
  String get rideDetailsTitle => 'Деталі поїздки';

  @override
  String get share => 'Поділитися';

  @override
  String get rideLoadError => 'Не вдалося завантажити поїздку';

  @override
  String get rideNotFoundTitle => 'Поїздку не знайдено';

  @override
  String get rideNotFoundDescription => 'Можливо, її вже було видалено.';

  @override
  String get routeLoadError => 'Не вдалося завантажити маршрут';

  @override
  String get achievements => 'Досягнення';

  @override
  String get longestRideAchievement => 'Найдовша поїздка';

  @override
  String get highestAverageSpeedAchievement => 'Найвища середня швидкість';

  @override
  String get longestMovingTimeAchievement => 'Найдовший час у русі';

  @override
  String get stats => 'Показники';

  @override
  String get totalTime => 'Загальний час';

  @override
  String get averageSpeed => 'Середня швидкість';

  @override
  String get maximumSpeed => 'Максимальна швидкість';

  @override
  String get unfinishedRideTitle => 'Незавершена поїздка';

  @override
  String unfinishedRideMessage(String ago, String distance) {
    return 'Схоже, застосунок закрився під час запису.\n\nПочата $ago тому · $distance\n\nПродовжити цю поїздку чи видалити запис?';
  }

  @override
  String get continueLabel => 'Продовжити';

  @override
  String startedDaysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count днів',
      few: '$count дні',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String startedHoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count години',
      many: '$count годин',
      few: '$count години',
      one: '$count годину',
    );
    return '$_temp0';
  }

  @override
  String startedMinutesAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хвилини',
      many: '$count хвилин',
      few: '$count хвилини',
      one: '$count хвилину',
    );
    return '$_temp0';
  }

  @override
  String get startedJustNow => 'щойно';

  @override
  String get statistics => 'Статистика';

  @override
  String get settings => 'Налаштування';

  @override
  String get rideListEmptyTitle => 'Час вирушати';

  @override
  String get rideListEmptyDescription => 'Запиши свою першу поїздку, і вона зʼявиться тут.';

  @override
  String get startRide => 'Почати поїздку';

  @override
  String get routeNotVisibleTitle => 'Маршрут ще не видно';

  @override
  String get routeNotVisibleDescription => 'У цій поїздці замало GPS-точок для відображення маршруту.';

  @override
  String get close => 'Закрити';

  @override
  String get showFullRoute => 'Показати весь маршрут';

  @override
  String get tryAgainLater => 'Спробуй ще раз трохи пізніше.';

  @override
  String get tryAgain => 'Спробувати ще';

  @override
  String get cancel => 'Скасувати';

  @override
  String get ridesLoadError => 'Не вдалося завантажити поїздки';

  @override
  String get hourShort => ' год';

  @override
  String get minuteShort => ' хв';

  @override
  String get secondShort => ' с';

  @override
  String get kilometerUnit => 'км';

  @override
  String get mileUnit => 'миль';

  @override
  String get kilometersPerHourUnit => 'км/год';

  @override
  String get milesPerHourUnit => 'миль/год';

  @override
  String get mapStyleCycling => 'Вело';

  @override
  String get mapStyleTerrain => 'Рельєф';

  @override
  String get mapStyleSatellite => 'Супутник';
}
