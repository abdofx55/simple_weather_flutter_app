import 'package:flutter/material.dart';
import 'package:weather/feature/home/domain/weather_usecase.dart';
import 'package:weather/util/location_manager.dart';
import 'package:weather/feature/home/domain/weather.dart';

class HomeViewModel extends ChangeNotifier {
  final GetWeatherUseCase _getWeatherUseCase = GetWeatherUseCase();
  final LocationManager _locationManager = LocationManager();
  Weather? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  HomeViewModel() {
    getWeatherByCoordinates();
  }

  Weather? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getWeatherByCoordinates() async {
    _setLoading(true);
    try {
      final location = await _locationManager.getCurrentLocation();
      _weatherData = await _getWeatherUseCase.getWeatherByCoordinates(location.latitude!, location.longitude!);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to get weather data.";
      debugPrint("Error: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getWeatherByCity(String cityName) async {
    _setLoading(true);
    try {
      _weatherData = await _getWeatherUseCase.getWeatherByCity(cityName);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "City is not found.";
      debugPrint("Error: $e");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}