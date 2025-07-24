class NetworkResponse {
  final StationsResponse network;

  NetworkResponse({required this.network});

  factory NetworkResponse.fromJson(Map<String, dynamic> json) {
    return NetworkResponse(
      network: StationsResponse.fromJson(json['network']),
    );
  }
}

class StationsResponse {
  final String id;
  final String name;
  final LocationResponse location;
  final String href;
  final List<String> company;
  final String gbfsHref;
  final List<StationResponse> stations;

  StationsResponse({
    required this.id,
    required this.name,
    required this.location,
    required this.href,
    required this.company,
    required this.gbfsHref,
    required this.stations,
  });

  factory StationsResponse.fromJson(Map<String, dynamic> json) {
    return StationsResponse(
      id: json['id'],
      name: json['name'],
      location: LocationResponse.fromJson(json['location']),
      href: json['href'],
      company: List<String>.from(json['company']),
      gbfsHref: json['gbfs_href'],
      stations: List<StationResponse>.from(json['stations'].map((s) => StationResponse.fromJson(s))),
    );
  }
}

class LocationResponse {
  final double latitude;
  final double longitude;
  final String city;
  final String country;

  LocationResponse({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      latitude: json['latitude'],
      longitude: json['longitude'],
      city: json['city'],
      country: json['country'],
    );
  }
}

class StationResponse {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String timestamp;
  final int freeBikes;
  final int emptySlots;
  final StationExtraResponse extra;

  StationResponse({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.freeBikes,
    required this.emptySlots,
    required this.extra,
  });

  factory StationResponse.fromJson(Map<String, dynamic> json) {
    return StationResponse(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: json['timestamp'],
      freeBikes: json['free_bikes'],
      emptySlots: json['empty_slots'],
      extra: StationExtraResponse.fromJson(json['extra']),
    );
  }
}

class StationExtraResponse {
  final String uid;
  final int renting;
  final int returning;
  final int lastUpdated;
  final List<String> payment;
  final bool paymentTerminal;
  final int slots;
  final bool virtualStation;

  StationExtraResponse({
    required this.uid,
    required this.renting,
    required this.returning,
    required this.lastUpdated,
    required this.payment,
    required this.paymentTerminal,
    required this.slots,
    required this.virtualStation,
  });

  factory StationExtraResponse.fromJson(Map<String, dynamic> json) {
    return StationExtraResponse(
      uid: json['uid'],
      renting: json['renting'],
      returning: json['returning'],
      lastUpdated: json['last_updated'],
      payment: List<String>.from(json['payment']),
      paymentTerminal: json['payment-terminal'],
      slots: json['slots'],
      virtualStation: json['virtual'],
    );
  }
}
