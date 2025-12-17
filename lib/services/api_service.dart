import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://192.168.1.8:8000/api";

  static Future<Map<String, dynamic>> getSensorData() async {
    final res = await http.get(Uri.parse("$baseUrl/sensor"));
    return json.decode(res.body);
  }

  static Future<Map<String, dynamic>> getChartData() async {
    final res = await http.get(Uri.parse("$baseUrl/chart"));
    return json.decode(res.body);
  }

  static Future<void> toggleServo() async {
    await http.post(Uri.parse("$baseUrl/servo/toggle"));
  }

  static Future<void> buzzerOff() async {
    await http.post(Uri.parse("$baseUrl/buzzer/off"));
  }
}
