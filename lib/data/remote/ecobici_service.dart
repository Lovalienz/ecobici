import 'dart:convert';
import 'package:ecobici/core/result.dart';
import 'package:ecobici/data/remote/dtos/network_response.dart';
import 'package:http/http.dart' as http;

class EcoBiciService {
  static const String _baseUrl = 'https://api.citybik.es/v2/networks/ecobici';

  Future<Result<NetworkResponse>> getEcoBiciData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final networkResponse = NetworkResponse.fromJson(jsonData);
        return Success(networkResponse);
      } else {
        return Failure(
          'Error ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      return Failure('Excepción: $e');
    }
  }
}
