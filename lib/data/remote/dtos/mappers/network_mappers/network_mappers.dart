import 'package:ecobici/data/remote/dtos/network_response.dart';
import 'package:ecobici/domain/models/network_model.dart';

extension NetworkMapper on NetworkResponse {
  Network toDomain() {
    return Network(stations: network.toDomain());
  }
}

extension StationsMapper on StationsResponse {
  Stations toDomain() {
    return Stations(
      id: id.isNotEmpty ? id : "",
      name: name.isNotEmpty ? name : "",
      location: location.toDomain(),
      href: href.isNotEmpty ? href : "",
      company: company.isNotEmpty ? company : [],
      gbfsHref: gbfsHref.isNotEmpty ? gbfsHref : "",
      stations: stations.map((s) => s.toDomain()).toList(),
    );
  }
}

extension LocationMapper on LocationResponse {
  Location toDomain() {
    return Location(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      city: city.isNotEmpty ? city : "",
      country: country.isNotEmpty ? country : "",
    );
  }
}

extension StationMapper on StationResponse {
  Station toDomain() {
    return Station(
      id: id.isNotEmpty ? id : "",
      name: name.isNotEmpty ? name : "",
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      timestamp: timestamp.isNotEmpty ? timestamp : "",
      freeBikes: freeBikes.toString(),
      emptySlots: emptySlots.toString(),
      extra: extra.toDomain(),
    );
  }
}

extension StationExtraMapper on StationExtraResponse {
  StationExtra toDomain() {
    return StationExtra(
      uid: uid.isNotEmpty ? uid : "",
      renting: renting.toString(),
      returning: returning.toString(),
      lastUpdated: lastUpdated.toString(),
      payment: payment.isNotEmpty ? payment : [],
      paymentTerminal: paymentTerminal,
      slots: slots.toString(),
      virtualStation: virtualStation,
    );
  }
}
