import 'package:ecobici/data/remote/dtos/network_response.dart';
import 'package:ecobici/domain/models/network_model.dart';

class StationDomainMapper {
  static Station toDomain(StationResponse response) {
    return Station(
      id: response.id,
      name: response.name,
      latitude: response.latitude.toString(),
      longitude: response.longitude.toString(),
      timestamp: response.timestamp,
      freeBikes: response.freeBikes.toString(),
      emptySlots: response.emptySlots.toString(),
      extra: StationExtra(
        uid: response.extra.uid,
        renting: response.extra.renting.toString(),
        returning: response.extra.returning.toString(),
        lastUpdated: response.extra.lastUpdated.toString(),
        payment: response.extra.payment,
        paymentTerminal: response.extra.paymentTerminal,
        slots: response.extra.slots.toString(),
        virtualStation: response.extra.virtualStation,
      ),
    );
  }

  static StationResponse fromDomain(Station station) {
    return StationResponse(
      id: station.id,
      name: station.name,
      latitude: double.parse(station.latitude),
      longitude: double.parse(station.longitude),
      timestamp: station.timestamp,
      freeBikes: int.parse(station.freeBikes),
      emptySlots: int.parse(station.emptySlots),
      extra: StationExtraResponse(
        uid: station.extra.uid,
        renting: int.parse(station.extra.renting),
        returning: int.parse(station.extra.returning),
        lastUpdated: int.parse(station.extra.lastUpdated),
        payment: station.extra.payment,
        paymentTerminal: station.extra.paymentTerminal,
        slots: int.parse(station.extra.slots),
        virtualStation: station.extra.virtualStation,
      ),
    );
  }
}
