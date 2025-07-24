import 'package:ecobici/data/remote/dtos/network_response.dart';
import 'package:hive/hive.dart';

class LocationResponseAdapter extends TypeAdapter<LocationResponse> {
  @override
  final int typeId = 1;

  @override
  LocationResponse read(BinaryReader reader) {
    return LocationResponse(
      latitude: reader.readDouble(),
      longitude: reader.readDouble(),
      city: reader.readString(),
      country: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, LocationResponse obj) {
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
    writer.writeString(obj.city);
    writer.writeString(obj.country);
  }
}

class StationExtraResponseAdapter extends TypeAdapter<StationExtraResponse> {
  @override
  final int typeId = 3;

  @override
  StationExtraResponse read(BinaryReader reader) {
    return StationExtraResponse(
      uid: reader.readString(),
      renting: reader.readInt(),
      returning: reader.readInt(),
      lastUpdated: reader.readInt(),
      payment: reader.readList().cast<String>(),
      paymentTerminal: reader.readBool(),
      slots: reader.readInt(),
      virtualStation: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, StationExtraResponse obj) {
    writer.writeString(obj.uid);
    writer.writeInt(obj.renting);
    writer.writeInt(obj.returning);
    writer.writeInt(obj.lastUpdated);
    writer.writeList(obj.payment);
    writer.writeBool(obj.paymentTerminal);
    writer.writeInt(obj.slots);
    writer.writeBool(obj.virtualStation);
  }
}

class StationResponseAdapter extends TypeAdapter<StationResponse> {
  @override
  final int typeId = 2;

  @override
  StationResponse read(BinaryReader reader) {
    return StationResponse(
      id: reader.readString(),
      name: reader.readString(),
      latitude: reader.readDouble(),
      longitude: reader.readDouble(),
      timestamp: reader.readString(),
      freeBikes: reader.readInt(),
      emptySlots: reader.readInt(),
      extra: reader.read() as StationExtraResponse,
    );
  }

  @override
  void write(BinaryWriter writer, StationResponse obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
    writer.writeString(obj.timestamp);
    writer.writeInt(obj.freeBikes);
    writer.writeInt(obj.emptySlots);
    writer.write(obj.extra);
  }
}

class StationsResponseAdapter extends TypeAdapter<StationsResponse> {
  @override
  final int typeId = 0;

  @override
  StationsResponse read(BinaryReader reader) {
    return StationsResponse(
      id: reader.readString(),
      name: reader.readString(),
      location: reader.read() as LocationResponse,
      href: reader.readString(),
      company: reader.readList().cast<String>(),
      gbfsHref: reader.readString(),
      stations: reader.readList().cast<StationResponse>(),
    );
  }

  @override
  void write(BinaryWriter writer, StationsResponse obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.write(obj.location);
    writer.writeString(obj.href);
    writer.writeList(obj.company);
    writer.writeString(obj.gbfsHref);
    writer.writeList(obj.stations);
  }
}
