// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_example/model/habit_list_model.dart';
import 'package:flutter_heatmap_example/model/habit_model.dart';
import 'package:flutter_heatmap_example/model/madedate_model.dart';
import 'package:flutter_heatmap_example/widgets/habit_heatmap_calendar_monthly_widget.dart';
import 'package:flutter_heatmap_example/widgets/habit_heatmap_calendar_weekly_widget.dart';
import 'package:flutter_heatmap_example/widgets/habit_heatmap_years_widget.dart';



class Deneme extends StatefulWidget {

  const Deneme({
    Key? key,
    
  }) : super(key: key);

  @override
  State<Deneme> createState() => _DenemeState();
}
final HabitListModel habitlist=HabitListModel(id: "id", title: "title",child:
     [HabitModel(id: "id", title: "title",createdAt: DateTime.now(), streakType: "Daily", unit: "ml", maxValue: 2000, incrementValue: 200, specialColor: Colors.blue, specialIcon: "Icons", dailyValue: 0  , madeDates: [MadeDatesModel(date: DateTime(2024, 8, 12), value: 1000),MadeDatesModel(date: DateTime(2024, 8, 13), value: 1800),MadeDatesModel(date: DateTime(2024, 8, 14), value: 600),MadeDatesModel(date: DateTime(2024, 8, 15), value: 100),MadeDatesModel(date: DateTime(2024, 8, 16), value: 1200),MadeDatesModel(date: DateTime(2024, 8, 17), value: 400),MadeDatesModel(date: DateTime(2024, 8, 18), value: 400), ])]  );
class _DenemeState extends State<Deneme> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 214, 214),
      appBar: AppBar(),
      body: Column(
        children:[
          
          HabitHeatmapYearsWidget(habitList:habitlist),
          const SizedBox(height: 20,),
          HabitHeatmapCalendarWeeklyWidget(habitList: habitlist,),
          const SizedBox(height: 20,),
          HabitHeatmapCalendarMonthly(habitList: habitlist,)

   
          ]
        ),
      
    );
  }
}

