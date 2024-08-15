import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar_inmanage/flutter_heatmap_calendar.dart';

import 'package:flutter_heatmap_example/model/habit_list_model.dart';
import 'package:flutter_heatmap_example/model/habit_model.dart';

class HabitHeatmapCalendarMonthly extends StatefulWidget {
  final HabitListModel habitList;
  const HabitHeatmapCalendarMonthly({
    Key? key,
    required this.habitList,
  }) : super(key: key);

  @override
  State<HabitHeatmapCalendarMonthly> createState() => _HabitHeatmapCalendarMonthlyState();
}

class _HabitHeatmapCalendarMonthlyState extends State<HabitHeatmapCalendarMonthly> {
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
    return 10; 
  }
   DateTime? findEarliestDate(HabitModel habit) {
    if (habit.madeDates == null || habit.madeDates!.isEmpty) {
      return null; 
    }

    final earliestDate = habit.madeDates!.map((e) => e.date).reduce((a, b) {
      return a.isBefore(b) ? a : b;
    });

    return earliestDate;
  }

  Map<DateTime, int> getHeatMapData(List<HabitModel>? habits) {
    Map<DateTime, int> heatMapData = {};

    if (habits == null) return heatMapData;

    for (var habit in habits) {
      for (var madeDate in habit.madeDates ?? []) {
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

  // En erken tarihi bulmak için nullable bir kontrol ekliyoruz
  DateTime? earliestDate;
  if (habits != null) {
    for (var habit in habits) {
      final habitEarliestDate = findEarliestDate(habit);
      if (habitEarliestDate != null) {
        if (earliestDate == null || habitEarliestDate.isBefore(earliestDate)) {
          earliestDate = habitEarliestDate;
        }
      }
    }}
    final now = DateTime.now();
    final startOfMonth =earliestDate ?? DateTime(now.year, now.month, 1);
   
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
     Map<DateTime, int> datasets = getHeatMapData(habits);
    for (int i = 0; i <= endOfMonth.difference(startOfMonth).inDays; i++) {
      final date = startOfMonth.add(Duration(days: i));
      datasets.putIfAbsent(date, () => 0); 
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: HeatMapCalendar(
        
        showColorTip: false,
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
          10: Color.fromARGB(255, 2, 179, 8),
        },
        datasets: datasets,
        initDate: earliestDate,
        size: 25,
        textColor: Colors.black87,
      ),
    );
  }
}