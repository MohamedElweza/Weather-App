import 'dart:convert';
import 'package:the_weather/models/weather_apiResponse.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<WeatherApiResponse> getApiData(String? city) async {
    final http.Response request = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&lat=44.34&lon=10.99&appid=12b1f4ef4db7b6460657b1c5f0291954'));
    if (request.statusCode <= 299 && request.statusCode >= 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(request.body);
      WeatherApiResponse weatherApiResponse =
          WeatherApiResponse.fromMap(jsonBody);
      return weatherApiResponse;
    } else {
      throw ('Request Fail' + request.body);
    }
  }
}
