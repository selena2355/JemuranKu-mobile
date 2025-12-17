import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/info_card.dart';
import '../widgets/chart_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  

  Map<String, dynamic> data = {};
  Map<String, dynamic> chart = {};
  bool servoActive = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    Timer.periodic(Duration(seconds: 5), (_) => fetchData());
  }

  Future<void> fetchData() async {
    final sensor = await ApiService.getSensorData();
    final chartData = await ApiService.getChartData();
    setState(() {
      data = sensor;
      chart = chartData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monitoring Jemuran IoT")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // Info Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoCard(title: "Suhu", value: "${data['temperature']}°C"),
                InfoCard(title: "Kelembapan", value: "${data['humidity']}%"),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoCard(title: "Kelembapan Baju", value: "${data['soil']}%"),
                InfoCard(title: "Rain", value: data['rain'] == 1 ? "Basah" : "Kering"),
              ],
            ),

            SizedBox(height: 20),

            // Kontrol
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      servoActive = !servoActive;
                    });
                    ApiService.toggleServo();
                  },
                  child: Text(servoActive ? "Teduhkan Jemuran" : "Panaskan Jemuran"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Chart Cards
            ChartCard(title: "Grafik Suhu", data: chart, field: "temperature"),
            ChartCard(title: "Grafik Kelembapan", data: chart, field: "humidity"),
            ChartCard(title: "Grafik Kelembapan Tanah", data: chart, field: "soil"),
            ChartCard(title: "Grafik Rain", data: chart, field: "rain"),

          ],
        ),
      ),
    );
  }
}
