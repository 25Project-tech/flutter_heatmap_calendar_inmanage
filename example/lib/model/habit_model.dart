
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_example/model/madedate_model.dart';






class HabitModel  {
  
  final String id;


  final String title;


  final int streak;


  final DateTime createdAt;


  final String? description;


  final String? category;


  final List<MadeDatesModel>? madeDates;


  final DateTime? startDate;

 
  final DateTime? endDate;


  final DateTime? reminderDate;


  final bool? isFavorite;


  final int? priotry;


  final int? frequency;


  final String streakType;


  final String unit;


  final int maxValue; //Hedef Değeri


  final int incrementValue; //Buton ile Artış değeri


  final Color specialColor;


   int currentValue;   //Şu anki değer


  final String specialIcon;


  final int dailyValue; //Günlük Artış Değeri

  HabitModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.streakType,
    required this.unit,
    required this.maxValue,
    required this.incrementValue,
    required this.specialColor,
    required this.specialIcon,
    this.currentValue =0,
    this.description,
    this.category,
    this.madeDates,
    this.startDate,
    this.endDate,
    this.reminderDate,
    this.isFavorite,
    this.priotry,
    this.frequency,
    this.streak = 0,
    required this.dailyValue,
  
  });
}
