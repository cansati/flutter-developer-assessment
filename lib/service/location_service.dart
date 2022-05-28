import 'dart:async';
import 'dart:ffi';
import 'package:flutter_developer_assessment/constant/application_constants.dart';
import 'package:flutter_developer_assessment/src/generated/poi.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import '../model/location.dart';

class LocationService {
  static PoiLocatorClient? client;

  Future<List<Location>> fetchLocations(String token) async {
    List<Map<String, dynamic>> mapJsonList = [];
    try {
      var channel = ClientChannel(ApplicationConstants.API_URL,
          port: ApplicationConstants.API_PORT,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ));
      client = PoiLocatorClient(channel,
          options: CallOptions(metadata: {
            "Authorization": "${ApplicationConstants.API_JWT_TOKEN_TYPE} $token"
          }));

      var response = client!.getPois(PoiRequest());
      var x = response.map((event) {
        return {
          "id": event.id.toString(),
          "lat": event.lat,
          "lon": event.lon,
          "name": event.name,
          "open_now": event.openNow,
          "website": event.website
        };
      });

      await x.forEach((element) {
        mapJsonList.add(element);
      });
      return locationFromJson(mapJsonList);
    } catch (e) {
      print(e);
    }
    return locationFromJson(mapJsonList);
  }
}
