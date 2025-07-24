class Network {
  final Stations stations;

  Network({required this.stations});
}

class Stations {
  final String id;
  final String name;
  final Location location;
  final String href;
  final List<String> company;
  final String gbfsHref;
  final List<Station> stations;

  Stations({
    required this.id,
    required this.name,
    required this.location,
    required this.href,
    required this.company,
    required this.gbfsHref,
    required this.stations,
  });

  factory Stations.empty() {
    return Stations(
      id: "",
      name: "",
      location: Location.empty(),
      href: "",
      company: [],
      gbfsHref: "",
      stations: [],
    );
  }
}

class Location {
  final String latitude;
  final String longitude;
  final String city;
  final String country;

  Location({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
  });

  factory Location.empty() {
    return Location(
      latitude: "0.0",
      longitude: "0.0",
      city: "",
      country: "",
    );
  }
}


class Station {
  final String id;
  final String name;
  final String latitude;
  final String longitude;
  final String timestamp;
  final String freeBikes;
  final String emptySlots;
  final StationExtra extra;

  Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.freeBikes,
    required this.emptySlots,
    required this.extra,
  });

  factory Station.empty() {
    return Station(
      id: "",
      name: "",
      latitude: "0.0",
      longitude: "0.0",
      timestamp: "",
      freeBikes: "0",
      emptySlots: "0",
      extra: StationExtra.empty(),
    );
  }
}

class StationExtra {
  final String uid;
  final String renting;
  final String returning;
  final String lastUpdated;
  final List<String> payment;
  final bool paymentTerminal;
  final String slots;
  final bool virtualStation;

  StationExtra({
    required this.uid,
    required this.renting,
    required this.returning,
    required this.lastUpdated,
    required this.payment,
    required this.paymentTerminal,
    required this.slots,
    required this.virtualStation,
  });

  factory StationExtra.empty() {
    return StationExtra(
      uid: "",
      renting: "0",
      returning: "0",
      lastUpdated: "0",
      payment: [],
      paymentTerminal: false,
      slots: "0",
      virtualStation: false,
    );
  }
}