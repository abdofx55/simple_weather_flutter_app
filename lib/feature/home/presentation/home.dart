import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:weather/feature/change_location/presentation/change_location.dart';
import 'package:weather/feature/home/presentation/home_viewmodel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _navigateToChangeLocation(
      BuildContext context, HomeViewModel viewModel) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChangeLocation(onCityChanged: (cityName) {
          viewModel.getWeatherByCity(cityName);
        }),
        transitionDuration: Duration.zero, // No animation duration
        reverseTransitionDuration: Duration.zero, // No reverse animation
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No transition animation
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.I.get<HomeViewModel>();
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Home'),
            ),
            backgroundColor: Colors.cyanAccent[100],
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (viewModel.isLoading)
                      const CircularProgressIndicator()
                    else if (viewModel.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          viewModel.errorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      )
                    else if (viewModel.weatherData != null) ...[
                      Text(
                        viewModel.weatherData!.cityName,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Temperature: ${viewModel.weatherData!.temperature}°C",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Humidity: ${viewModel.weatherData!.humidity}%",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Wind Speed: ${viewModel.weatherData!.windSpeed} m/s",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Weather: ${viewModel.weatherData!.description}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () =>
                          _navigateToChangeLocation(context, viewModel),
                      child: const Text('Change Location'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
