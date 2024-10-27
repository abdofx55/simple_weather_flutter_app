import 'package:flutter/material.dart';
import 'package:weather/feature/change_location/presentation/change_location_viewmodel.dart';
import 'package:weather/feature/home/presentation/home.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/feature/home/presentation/home_viewmodel.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<ChangeLocationViewModel>(
      () => ChangeLocationViewModel());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            inversePrimary: Colors.deepPurpleAccent,
            seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 21.0),
            centerTitle: true),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
