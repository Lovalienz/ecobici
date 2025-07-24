import 'package:ecobici/di/setup_locator.dart';
import 'package:ecobici/presentation/ui/map/map_screen.dart';
import 'package:ecobici/presentation/ui/stations/utils/flutter_elastic_list_view.dart';
import 'package:ecobici/presentation/viewmodels/stations_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StationsWrapper extends StatelessWidget {
  const StationsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationsViewModel>(
      create: (_) => getIt<StationsViewModel>(),
      child: const Stations(),
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
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final vm = context.read<StationsViewModel>();
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        vm.loadNextPage();
      }
      _searchController.addListener(() {
        final query = _searchController.text;
        vm.filterStationsByName(query);
        setState(() {}); // Para que el `searchText` se refleje en el `build`
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar estación...',
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  viewModel.filterStationsByName(text);
                },
              )
            : Row(
                children: [
                  const Text(
                    'Encuentra tu Ecobici',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 130,
                    height: 80,
                    child: Lottie.asset(
                      'assets/bicycle_riding.json',
                      repeat: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  _searchController.clear();
                  viewModel.filterStationsByName('');
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ElasticListView(
            controller: _scrollController,
            children: viewModel.stations.map((station) {
              return GestureDetector(
                onTap: () {
                  viewModel.selectStation(station);
                },
                child: Container(
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
                ),
              );
            }).toList(),
          ),

          if (isSearching)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _searchController.text.isEmpty
                        ? viewModel.recentViewed.length
                        : viewModel.filteredStations.length,
                    itemBuilder: (context, index) {
                      final station = _searchController.text.isEmpty
                          ? viewModel.recentViewed[index]
                          : viewModel.filteredStations[index];

                      return GestureDetector(
                        onTap: () {
                          viewModel.selectStation(station);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                station.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('ID: ${station.id}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          // Mapa con estación seleccionada
          if (viewModel.selectedStation != null)
            Positioned.fill(
              child: Material(
                color: Colors.black.withOpacity(0.5),
                child: Stack(
                  children: [
                    MapWithPolylineScreen(
                      selectedStation: viewModel.selectedStation!,
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => viewModel.clearSelectedStation(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
