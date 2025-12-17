import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;
  final String field;

  const ChartCard({super.key, required this.title, required this.data, required this.field});

  @override
  Widget build(BuildContext context) {
    // Extract labels and field data
    List<String> labels = List<String>.from(data['labels'] ?? []);
    List<dynamic> values = data[field] ?? [];

    // Convert values to doubles and create FlSpot data
    List<FlSpot> spots = [];
    for (int i = 0; i < values.length; i++) {
      double y = double.tryParse(values[i].toString()) ?? 0;
      spots.add(FlSpot(i.toDouble(), y));
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 20),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 280,
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: spots.isEmpty
                  ? Center(child: Text('No data available'))
                  : LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < labels.length) {
                                  return Text(labels[index], style: TextStyle(fontSize: 10));
                                }
                                return Text('');
                              },
                              reservedSize: 30,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                            color: Colors.blue,
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
