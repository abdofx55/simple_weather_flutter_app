import 'package:weather/feature/home/data/weather_repository.dart';
import 'package:weather/feature/home/domain/weather.dart';

class GetWeatherUseCase {
  final WeatherRepository repository = WeatherRepository();

  Future<Weather> getWeatherByCoordinates(double lat, double lon) {
    return repository.getWeatherByCoordinates(lat, lon);
  }

  Future<Weather> getWeatherByCity(String cityName) {
    return repository.getWeatherByCity(cityName);
  }
}