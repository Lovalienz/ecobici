
import 'package:ecobici/core/result.dart';
import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/usecases/paginate_usecase.dart';
import 'package:ecobici/domain/usecases/stations_usecase.dart';
import 'package:flutter/material.dart';

class StationsViewModel extends ChangeNotifier {
  final GetLocalNetworkPaginatedUseCase getLocalStations;
  final GetStationsiUseCase getRemoteStations;

  Network? network;
  List<Station> stations = [];
  bool isLoading = false;
  String? errorMessage;
  bool _isLoadingNextStations = false;
  int _currentPage = 0;
  final int _pageSize = 10;

  StationsViewModel({
    required this.getLocalStations,
    required this.getRemoteStations,
  }){
    fetchRemoteStations();
  }


 Future<void> loadNextPage() async {
  if (_isLoadingNextStations) return;

  _isLoadingNextStations = true;
  _currentPage++;
  final result = await getLocalStations(_currentPage, _pageSize);
  stations.addAll(result);
  _isLoadingNextStations = false;
  notifyListeners();
}

  Future<void> fetchRemoteStations() async {
    _setLoading(true);
    final result = await getRemoteStations();

    switch (result) {
      case Success<Stations>():
        final localStations = await getLocalStations(_currentPage, _pageSize);
        stations = localStations;
        break;

      case Failure<Stations>():
        errorMessage = result.message;
        break;

      case Loading<Stations>():
        break;
    }

    _setLoading(false);
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void reset() {
    stations.clear();
    _currentPage = 0;
    errorMessage = null;
    notifyListeners();
  }
}
