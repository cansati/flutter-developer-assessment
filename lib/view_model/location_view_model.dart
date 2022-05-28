import 'package:flutter/foundation.dart';
import '../model/location.dart';
import '../service/location_service.dart';

enum LocationState { IDLE, BUSY, ERROR }

class LocationViewModel with ChangeNotifier {
  late LocationState state;
  late List<Location> locationList;

  LocationViewModel() {
    locationList = [];
    locationState(LocationState.BUSY);
  }

  void locationState(LocationState xstate) {
    state = xstate;
    notifyListeners();
  }

  Future<List<Location>> fetchLocations(String token) async {
    try {
      locationState(LocationState.BUSY);
      locationList = await LocationService().fetchLocations(token);
      return locationList;
    } catch (e) {
      print(e);
      locationState(LocationState.ERROR);
      return [];
    }
  }
}
