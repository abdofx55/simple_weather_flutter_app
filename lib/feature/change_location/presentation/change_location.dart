import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:weather/feature/change_location/presentation/change_location_viewmodel.dart';

class ChangeLocation extends StatelessWidget {
  final Function(String) onCityChanged;

  final TextEditingController _cityController = TextEditingController();

  ChangeLocation({
    super.key,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.I.get<ChangeLocationViewModel>();
    return ChangeNotifierProvider<ChangeLocationViewModel>.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Change Location'),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyanAccent[100],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ChangeLocationViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      viewModel.setCity(value);
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        onCityChanged(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: viewModel.city.isNotEmpty
                        ? () {
                            onCityChanged(viewModel.city);
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text('Change Location'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
