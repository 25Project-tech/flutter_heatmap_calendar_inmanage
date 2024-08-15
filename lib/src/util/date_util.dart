
 class DateUtil {
  // ignore: constant_identifier_names
  static const int DAYS_IN_WEEK = 7;

  // ignore: constant_identifier_names
  static const List<String> MONTH_LABEL = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // ignore: constant_identifier_names
  static const List<String> SHORT_MONTH_LABEL = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  // ignore: constant_identifier_names
  static const List<String> WEEK_LABEL = [
    '',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    
  ];
    // ignore: constant_identifier_names
    static const List<String> Short_WEEK_LABEL = [
    '',
    
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
    'S',
  ];

  /// Get start day of month. 
  static DateTime startDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month,1);

  /// gün eklendi    
  static DateTime startDayOfMonthCustom(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month,referenceDate.day);

  /// Get last day of month.
  static DateTime endDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month + 1, 0);

  /// Get exactly one year before of [referenceDate].
  static DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  /// Separate [referenceDate]'s month to List of every weeks.
  static List<Map<DateTime, DateTime>> separatedMonth(
      final DateTime referenceDate) {
    DateTime _startDate = startDayOfMonth(referenceDate);
    DateTime _endDate = DateTime(_startDate.year, _startDate.month,
        _startDate.day + DAYS_IN_WEEK - _startDate.weekday % DAYS_IN_WEEK - 1);
    DateTime _finalDate = endDayOfMonth(referenceDate);
    List<Map<DateTime, DateTime>> _savedMonth = [];

    while (_startDate.isBefore(_finalDate) || _startDate == _finalDate) {
      _savedMonth.add({_startDate: _endDate});
      _startDate = changeDay(_endDate, 1);
      _endDate = changeDay(
          _endDate,
          endDayOfMonth(_endDate).day - _startDate.day >= DAYS_IN_WEEK
              ? DAYS_IN_WEEK
              : endDayOfMonth(_endDate).day - _startDate.day + 1);
    }
    return _savedMonth;
  }

  /// Change day of [referenceDate].
  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);

  /// Change month of [referenceDate].
  static DateTime changeMonth(final DateTime referenceDate, int monthCount) =>
      DateTime(referenceDate.year, referenceDate.month + monthCount,
          referenceDate.day);

  static List<Map<DateTime, DateTime>> separatedWeek(
    final DateTime referenceDate) {
  DateTime startDate = referenceDate.subtract(Duration(days: referenceDate.weekday - 1));
  DateTime endDate = startDate.add(const Duration(days: 6));
  return [{startDate: endDate}];
}


  //#region unused methods.

  // static int weekCount(final DateTime referenceDate) {
  //   return ((startDayOfMonth(referenceDate).weekday % DAYS_IN_WEEK +
  //               endDayOfMonth(referenceDate).day) /
  //           DAYS_IN_WEEK)
  //       .ceil();
  // }

  // static int weekPos(final DateTime referenceDate) =>
  //     (referenceDate.day +
  //         startDayOfMonth(referenceDate).weekday % DAYS_IN_WEEK) ~/
  //     DAYS_IN_WEEK;

  // static DateTime startDayOfWeek(final DateTime referenceDate) =>
  //     weekPos(referenceDate) == 0
  //         ? startDayOfMonth(referenceDate)
  //         : DateTime(referenceDate.year, referenceDate.month,
  //             referenceDate.day - referenceDate.weekday % DAYS_IN_WEEK);

  // static DateTime endDayOfWeek(final DateTime referenceDate) {
  //   return weekPos(referenceDate) != (weekCount(referenceDate) - 1)
  //       ? DateTime(referenceDate.year, referenceDate.month,
  //           referenceDate.day - referenceDate.weekday % DAYS_IN_WEEK + 6)
  //       : endDayOfMonth(referenceDate);
  // }

  // static DateTime changeWeek(final DateTime referenceDate, int weekCount) =>
  //     DateTime(referenceDate.year, referenceDate.month,
  //         1 + DAYS_IN_WEEK * weekCount);

  // static bool compareDate(final DateTime first, final DateTime second) =>
  //     first.year == second.year &&
  //     first.month == second.month &&
  //     first.day == second.day;

  // static bool isStartDayOfMonth(final DateTime referenceDate) =>
  //     compareDate(referenceDate, startDayOfMonth(referenceDate));

  //#endregion
}
 