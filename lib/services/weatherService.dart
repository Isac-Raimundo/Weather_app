import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/apikey.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final String apiKey = chave;

  Future<Weather> searchWeather(String city) async{
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=pt_br'
    );

    final answer = await http.get(url);

    if (answer.statusCode == 200) {
      print(jsonDecode(answer.body));
      return Weather.fromJson(jsonDecode(answer.body));
    } else {
      throw Exception('Erro ao buscar dados: ${answer.statusCode}');
    }
  }
}
