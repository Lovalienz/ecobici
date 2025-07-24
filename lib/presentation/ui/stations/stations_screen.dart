import 'package:ecobici/di/setup_locator.dart';
import 'package:ecobici/presentation/ui/stations/utils/flutter_elastic_list_view.dart';
import 'package:ecobici/presentation/viewmodels/stations_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationsWrapper extends StatelessWidget {
  const StationsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationsViewModel>(
      create: (_) => getIt<StationsViewModel>(),
      child: const Stations(), // tu widget padre original
    );
  }
}

class Stations extends StatefulWidget {
  const Stations({super.key});

  @override
  State<Stations> createState() => _StationsState();
}

class _StationsState extends State<Stations> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final vm = context.read<StationsViewModel>();

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        vm.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuentra tu Ecobici'),
      ),
      body: ElasticListView(
        controller: _scrollController,
        children: viewModel.stations.map((station) {
          return Container(
            height: 100,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('ID: ${station.id}'),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

