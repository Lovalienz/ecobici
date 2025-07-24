
import 'package:ecobici/domain/models/network_model.dart';
import 'package:flutter/material.dart';

class StyationsViewModel extends ChangeNotifier {
  final GetNetworkFromApiUseCase getNetworkFromApi;
  final GetLocalNetworkPaginatedUseCase getLocalStations;

  Network? network;
  List<Station> stations = [];
  bool isLoading = false;

  int _currentPage = 0;
  final int _pageSize = 10;

  NetworkViewModel(this.getNetworkFromApi, this.getLocalStations);

  Future<void> fetchNetwork(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      network = await getNetworkFromApi(id);
      _currentPage = 0;
      stations = getLocalStations(_currentPage, _pageSize);
    } catch (e) {
      // manejar errores
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void loadNextPage() {
    _currentPage++;
    final newStations = getLocalStations(_currentPage, _pageSize);
    stations.addAll(newStations);
    notifyListeners();
  }
}
