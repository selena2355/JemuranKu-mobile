import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final List data;
  final String field;

  const ChartCard({super.key, required this.title, required this.data, required this.field});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 220,
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data.map<FlSpot>((d) {
                        double t = double.tryParse(d['time_index'].toString()) ?? 0;
                        double v = double.tryParse(d[field].toString()) ?? 0;
                        return FlSpot(t, v);
                      }).toList(),
                      isCurved: true,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
