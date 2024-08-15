// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_example/model/habit_list_model.dart';
import 'package:flutter_heatmap_example/model/habit_model.dart';

import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HabitHeatmapYearsWidget extends StatefulWidget {
  final HabitListModel habitList;
  const HabitHeatmapYearsWidget({
    Key? key,
    required this.habitList,
  }) : super(key: key);

  @override
  State<HabitHeatmapYearsWidget> createState() => _HabitHeatmapYearsWidgetState();
}

class _HabitHeatmapYearsWidgetState extends State<HabitHeatmapYearsWidget> {
    int calculateIntensity(double ratio) {
     
    if (ratio <= 0.1) return 1;
    if (ratio <= 0.2) return 2;
    if (ratio <= 0.3) return 3;
    if (ratio <= 0.4) return 4;
    if (ratio <= 0.5) return 5;
    if (ratio <= 0.6) return 6;
    if (ratio <= 0.7) return 7;
    if (ratio <= 0.8) return 8;
    if (ratio <= 0.9) return 9;
    return 10; // 1'e yakın veya daha yüksekse en koyu renk
  }

  DateTime? findEarliestDate(HabitModel habit) {
    if (habit.madeDates == null || habit.madeDates!.isEmpty) {
      return null; // Eğer madeDates listesi boş veya null ise
    }

    // En erken tarihi bulmak için reduce fonksiyonu kullanılıyor
    final earliestDate = habit.madeDates!.map((e) => e.date).reduce((a, b) {
      return a.isBefore(b) ? a : b;
    });

    return earliestDate;
  }

  DateTime? findOverallEarliestDate(List<HabitModel>? habits) {
    if (habits == null || habits.isEmpty) {
      return null;
    }

    DateTime? overallEarliestDate;

    for (var habit in habits) {
      DateTime? earliestDate = findEarliestDate(habit);
      if (earliestDate != null) {
        if (overallEarliestDate == null || earliestDate.isBefore(overallEarliestDate)) {
          overallEarliestDate = earliestDate;
        }
      }
    }

    return overallEarliestDate;
  }

  // Verileri HeatMapCalendar için uygun formata dönüştürme
  Map<DateTime, int> getHeatMapData(List<HabitModel>? habits) {
    Map<DateTime, int> heatMapData = {};

    if (habits == null) return heatMapData;

    for (var habit in habits) {
      for (var madeDate in habit.madeDates ?? []) {
        // Tarih kısmını al ve saat-dakika bilgisini sıfırla
        DateTime dateOnly = DateTime(madeDate.date.year, madeDate.date.month, madeDate.date.day);
        
        double currentValue = madeDate.value.toDouble();
        double targetValue = habit.maxValue.toDouble();

        if (targetValue > 0) {
          double ratio = currentValue / targetValue;
          int intensity = calculateIntensity(ratio);
          heatMapData[dateOnly] = intensity;
        } else {
          heatMapData[dateOnly] = 1;
        }
      }
    }
    return heatMapData;
  }
  @override
  Widget build(BuildContext context) {
    final habits = widget.habitList.child;

    // En erken tarihi bul
    DateTime? earliestDate = findOverallEarliestDate(habits);
    final startOfYear = earliestDate ?? DateTime.now(); // Eğer en erken tarih yoksa şimdiki tarih kullanılır

    final endOfYear = DateTime(startOfYear.year , 12, 31);

    // Bir yıllık tarihleri doldur
    Map<DateTime, int> datasets = getHeatMapData(habits);
    for (int i = 0; i <= endOfYear.difference(startOfYear).inDays; i++) {
      final date = startOfYear.add(Duration(days: i));
      datasets.putIfAbsent(date, () => 0); // Verisi olmayan tarihler için 0 yoğunluk
    }
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: HeatMap(
            colorMode: ColorMode.color,
            colorsets: const {
              
              1: Color.fromARGB(20, 2, 179, 8),
              2: Color.fromARGB(40, 2, 179, 8),
              3: Color.fromARGB(60, 2, 179, 8),
              4: Color.fromARGB(80, 2, 179, 8),
              5: Color.fromARGB(100, 2, 179, 8),
              6: Color.fromARGB(120, 2, 179, 8),
              7: Color.fromARGB(150, 2, 179, 8),
              8: Color.fromARGB(180, 2, 179, 8),
              9: Color.fromARGB(220, 2, 179, 8),
              10:Color.fromARGB(255, 2, 179, 8),
            },
            showColorTip: false,
            datasets: datasets,
            startDate: startOfYear, // Başlangıç tarihi olarak en erken veri tarihi
            endDate: endOfYear, // Bitiş tarihi olarak bir yıl sonrası
            size: 15, // Kutuların boyutunu ayarlamak için
            textColor: Colors.black,
          ),
        );
  }
}