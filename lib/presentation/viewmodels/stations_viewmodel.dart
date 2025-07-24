import 'package:ecobici/core/result.dart';
import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/usecases/get_recent_viewed_usecase.dart';
import 'package:ecobici/domain/usecases/paginate_usecase.dart';
import 'package:ecobici/domain/usecases/get_stations_usecase.dart';
import 'package:ecobici/domain/usecases/save_recent_viewed_usecase.dart';
import 'package:flutter/material.dart';

class StationsViewModel extends ChangeNotifier {
  final GetLocalNetworkPaginatedUseCase getLocalStations;
  final GetStationsiUseCase getRemoteStations;
  final GetRecentViewedStationsUseCase getRecentViewed;
  final SaveRecentViewedStationUseCase saveRecentViewed;

  Network? network;
  List<Station> stations = [];
  bool isLoading = false;
  String? errorMessage;
  bool _isLoadingNextStations = false;
  int _currentPage = 0;
  final int _pageSize = 10;
  Station? _selectedStation;
  Station? get selectedStation => _selectedStation;
  List<Station> _filteredStations = [];
  List<Station> get filteredStations => _filteredStations;
  List<Station> _recentViewed = [];
  List<Station> get recentViewed => _recentViewed;

  StationsViewModel({
    required this.getLocalStations,
    required this.getRemoteStations,
    required this.getRecentViewed,
    required this.saveRecentViewed,
  }) {
    fetchRemoteStations();
  }

  void selectStation(Station station) async {
    await saveRecentViewed(station);
    final recents = await getRecentViewed();
    _recentViewed = recents.reversed.toList();
    _selectedStation = station;
    notifyListeners();
  }

  void clearSelectedStation() {
    _selectedStation = null;
    notifyListeners();
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

  void filterStationsByName(String query) {
    _filteredStations = stations.where((station) {
      return station.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void resetStationFilter() {
    _filteredStations = stations;
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
