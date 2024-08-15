import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar_inmanage/src/util/date_util.dart';

import '../util/datasets_util.dart';
import '../data/heatmap_color_mode.dart';


class HeatMapCalendarPageWeekly extends StatelessWidget {
  final DateTime baseDate;
  final EdgeInsets? margin;
  final bool? flexible;
  final double? size;
  final double? fontSize;
  final Map<DateTime, int>? datasets;
  final Color? defaultColor;
  final Color? textColor;
  final ColorMode colorMode;
  final Map<int, Color>? colorsets;
  final double? borderRadius;
  final TextStyle? textStyle;
  final MainAxisAlignment? mainAxisAlignment;

  const HeatMapCalendarPageWeekly({Key? key, 
    required this.baseDate,
    this.margin,
    this.flexible,
    this.size,
    this.fontSize,
    this.datasets,
    this.defaultColor,
    this.textColor,
    this.colorMode = ColorMode.opacity,
    this.colorsets,
    this.borderRadius,
    this.textStyle,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    // Haftanın başlangıç ve bitiş tarihlerini hesaplayın
    DateTime startDate = baseDate.subtract(Duration(days: baseDate.weekday - 1));
    DateTime endDate = startDate.add(const Duration(days: 6));

    // Haftalık verileri filtreleyin
    Map<DateTime, int>? weeklyData = DatasetsUtil.filterWeek(datasets, startDate, endDate);
    
    return Row(
      
      mainAxisAlignment: mainAxisAlignment?? MainAxisAlignment.start,
      children: List.generate(7, (index) {
         
        DateTime currentDate = startDate.add(Duration(days: index));
        String label = DateUtil.Short_WEEK_LABEL[index+1];
        return HeatMapCalendarBox(
          date: currentDate,
          value: weeklyData[currentDate] ?? 0,
          size: size,
          fontSize: fontSize,
          defaultColor: defaultColor,
          textColor: textColor,
          colorMode: colorMode,
          colorsets: colorsets,
          borderRadius: borderRadius,
          textStyle:textStyle ,
           label: label,
           margin: margin,

           
        );
      }),
    );
  }
}

class HeatMapCalendarBox extends StatelessWidget {
  final DateTime date;
  final int value;
  final double? size;
  final double? fontSize;
  final Color? defaultColor;
  final Color? textColor;
  final ColorMode colorMode;
  final Map<int, Color>? colorsets;
  final double? borderRadius;
  final String label;
  final EdgeInsets? margin;
  final TextStyle? textStyle;
  final MainAxisAlignment? mainAxisAlignment;


  const HeatMapCalendarBox({Key? key, 
    required this.date,
    required this.value,
    this.size,
    this.fontSize,
    this.defaultColor,
    this.textColor,
    this.colorMode = ColorMode.opacity,
    this.colorsets,
    this.borderRadius,
    required this.label,  
    this.margin,
    this.textStyle,
     this.mainAxisAlignment,

  }) : super(key: key);
   
  @override
  Widget build(BuildContext context) {

    // Kutunun rengini ve diğer özelliklerini burada ayarlayın
    return Container(
      margin:  margin ??  const EdgeInsets.symmetric(horizontal: 4), 
      width: size ?? 40.0,
      height:size??  40.0,
        decoration: BoxDecoration(
        color: colorsets?[value] ?? defaultColor ?? Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
      ),  
      child: Center(
        child: Text(
           label ,
          style:textStyle ?? const TextStyle(
            fontSize:14.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

















////////////////////////////////
///
/* import 'package:flutter/material.dart';
import './heatmap_calendar_row.dart';
import '../util/date_util.dart';
import '../util/datasets_util.dart';
import '../data/heatmap_color_mode.dart';

class HeatMapCalendarPage extends StatelessWidget {
  /// The DateTime value which contains the current calendar's date value.
  final DateTime baseDate;

  ///
  final Map<DateTime, DateTime> weekDate;
  /// The list value of the map value that contains
  /// separated start and end of every weeks on month.
  ///
  /// Separate [datasets] using [DateUtil.separatedMonth].
  final List<Map<DateTime, DateTime>> separatedDate;

  /// The margin value for every block.
  final EdgeInsets? margin;

  /// Make block size flexible if value is true.
  final bool? flexible;

  /// The double value of every block's width and height.
  final double? size;

  /// The double value of every block's fontSize.
  final double? fontSize;

  /// The datasets which fill blocks based on its value.
  final Map<DateTime, int>? datasets;

  /// The default background color value of every blocks
  final Color? defaultColor;

  /// The text color value of every blocks
  final Color? textColor;

  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// dynamically based on hightest value of [datasets].
  /// [ColorMode.color] changes colors based on [colorsets] thresholds key value.
  final ColorMode colorMode;

  /// The colorsets which give the color value for its thresholds key value.
  ///
  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  final Map<int, Color>? colorsets;

  /// The double value of every block's borderRadius
  final double? borderRadius;

  /// The integer value of the maximum value for the [datasets].
  ///
  /// Filtering [datasets] with [baseDate] using [DatasetsUtil.filterMonth].
  /// And get highest key value of filtered datasets using [DatasetsUtil.getMaxValue].
  final int? maxValue;

  /// Function that will be called when a block is clicked.
  ///
  /// Paratmeter gives clicked [DateTime] value.
  final Function(DateTime)? onClick;

  HeatMapCalendarPage({
    Key? key,
    required this.baseDate,
    required this.colorMode,
    this.flexible,
    this.size,
    this.fontSize,
    this.defaultColor,
    this.textColor,
    this.margin,
    this.datasets,
    this.colorsets,
    this.borderRadius,
    this.onClick,
     required this.weekDate,
  })  : separatedDate = DateUtil.separatedMonth(baseDate),
        maxValue = DatasetsUtil.getMaxValue(
            DatasetsUtil.filterMonth(datasets, baseDate)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (MapEntry<DateTime,DateTime> entry in weekDate.entries)
          HeatMapCalendarRow(
            startDate: entry.key,
            endDate: entry.value,
            colorMode: colorMode,
            size: size,
            fontSize: fontSize,
            defaultColor: defaultColor,
            colorsets: colorsets,
            textColor: textColor,
            borderRadius: borderRadius,
            flexible: flexible,
            margin: margin,
            maxValue: maxValue,
            onClick: onClick,
            datasets: DatasetsUtil.filterWeek(datasets, entry.key, entry.value),
          ),
      ],
    );
  }
}
///data sets Map.from(datasets ?? {})
          /*     ..removeWhere(
                (key, value) => !(key.isAfter(date.keys.first) &&
                        key.isBefore(date.values.first) ||
                    key == date.keys.first ||
                    key == date.values.first),
              ), */ */