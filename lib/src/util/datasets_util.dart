import 'package:flutter/material.dart';
import './date_util.dart';

class DatasetsUtil {
static Map<DateTime, int> filterWeek(Map<DateTime, int>? datasets, DateTime startDate, DateTime endDate) {
    if (datasets == null) {
      return {};
    }

    return Map.fromEntries(
      datasets.entries.where((entry) {
        return entry.key.isAfter(startDate.subtract(const Duration(days: 1))) && entry.key.isBefore(endDate.add(const Duration(days: 1)));
      }),
    );
  }
  
  /// Filtering [datasets] where the key is on the same month of [referenceDate].
  static Map<DateTime, int> filterMonth(
      Map<DateTime, int>? datasets, DateTime referenceDate) {
    return Map.from(datasets ?? {})
      ..removeWhere(
        (date, value) =>
            !(date.isAfter(DateUtil.startDayOfMonth(referenceDate)) &&
                    date.isBefore(DateUtil.endDayOfMonth(referenceDate)) ||
                date == DateUtil.endDayOfMonth(referenceDate) ||
                date == DateUtil.startDayOfMonth(referenceDate)),
      );
  }

  /// Get maximum value of [datasets].
  static int getMaxValue(Map<DateTime, int>? datasets) {
    int result = 0;

    datasets?.forEach((date, value) {
      if (value > result) {
        result = value;
      }
    });

    return result;
  }

  /// Get color from [colorsets] using [dataValue].
  static Color? getColor(Map<int, Color>? colorsets, int? dataValue) {
    int result = 0;

    colorsets?.forEach((key, value) {
      if (key <= (dataValue ?? 0)) result = key;
    });

    return colorsets?[result];
  }
}
