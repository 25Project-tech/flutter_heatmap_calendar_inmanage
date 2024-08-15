




import 'package:flutter_heatmap_example/model/habit_model.dart';

class HabitListModel {

  
  final String id;


  final String title;

  
  final List<HabitModel>? child;

  HabitListModel( {this.child ,required this.id, required this.title, }); 



}