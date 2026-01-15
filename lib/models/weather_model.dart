
class Weather {
  // variáveis da api
  final String cityName;
  final String country;
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double windSpeed;
  final double humidity;
  final int dt;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.country,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.windSpeed,
    required this.humidity,
    required this.dt,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> openWeatherMap) {
    return Weather(
      cityName: openWeatherMap['name'],//
      country: openWeatherMap['sys']['country'],//
      description: openWeatherMap['weather'][0]['description'],//
      icon: openWeatherMap['weather'][0]['icon'],//
      temperature: openWeatherMap['main']['temp'].toDouble(),//
      feelsLike: openWeatherMap['main']['feels_like'].toDouble(),//
      tempMin: openWeatherMap['main']['temp_min'].toDouble(),//
      tempMax: openWeatherMap['main']['temp_max'].toDouble(),//
      windSpeed: openWeatherMap['wind']['speed'].toDouble(),
      humidity: openWeatherMap['main']['humidity'].toDouble(),
      dt: openWeatherMap['dt'], //
      sunrise: openWeatherMap['sys']['sunrise'],//
      sunset: openWeatherMap['sys']['sunset'],//
    );
  }
}
