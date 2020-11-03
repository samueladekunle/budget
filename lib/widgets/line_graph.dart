import 'dart:math';

import 'package:budget/constants.dart';
import 'package:budget/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineGraph extends StatefulWidget {
  final double amount;
  final Month month;

  const LineGraph({
    Key key,
    @required this.amount,
    @required this.month,
  }) : super(key: key);

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  List<int> _getListOfAmount() {
    final list = <int>[];

    if (widget.amount / 1000 >= 2) {
      for (int index = 1000; index <= widget.amount; index += 1000) {
        list.add(index);
      }
    } else {
      for (int index = 500; index <= widget.amount; index += 500) {
        list.add(index);
      }
    }

    return list;
  }

  List<int> _getListOfDays() {
    final numberOfDays = widget.month.numberOfDays;
    final list = <int>[];

    if (numberOfDays >= 30) {
      for (var day = 5; day <= numberOfDays; day += 5) {
        list.add(day);
      }
    } else {
      for (var day = 4; day <= numberOfDays; day += 4) {
        list.add(day);
      }
    }

    return list;
  }

  List<FlSpot> _getSpots() {
    final list = <FlSpot>[];
    final days = _getListOfDays();
    for (var day in days) {
      final dy = double.parse(
          '${(Random().nextDouble() * widget.amount.toInt()).toStringAsFixed(2)}');
      list.add(FlSpot(day.toDouble(), dy));
    }
    return list;
  }

  LineChartData _buildLineGraph() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white.withOpacity(0.8),
            getTooltipItems: (list) {
              return list
                  .map((item) => LineTooltipItem(numberFormat.format(item.y),
                      TextStyle(color: Theme.of(context).accentColor)))
                  .toList();
            }),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          // margin: 10,
          margin: 20,
          getTitles: (value) {
            if (_getListOfDays().contains(value.toInt())) {
              return '${value.toInt()}';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (_getListOfAmount().contains(value.toInt())) {
              return '${value.toInt()}';
            }
            return '';
          },
          reservedSize: 22,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      // maxX: 14,
      maxX: _getListOfDays().last.toDouble(),
      // maxY: 4,
      maxY: _getListOfAmount().last.toDouble(),
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: _getSpots(),
          isCurved: true,
          colors: [
            pinkColor,
          ],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${numberFormat.format(widget.amount)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 17, left: 6.0),
                child: LineChart(_buildLineGraph()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
