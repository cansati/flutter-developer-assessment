import 'package:flutter/foundation.dart';
import '../model/location.dart';

enum FavouritesState { IDLE, BUSY, ERROR }

class FavouritesViewModel with ChangeNotifier {
  late FavouritesState state;
  List<Location> favLocationsList = [];

  FavouritesViewModel() {
    favouritesState(FavouritesState.IDLE);
  }

  void favouritesState(FavouritesState xstate) {
    state = xstate;
    notifyListeners();
  }

  void addOrPopFavourite(Location location) {
    int x = favLocationsList.indexWhere((element) => element.id == location.id);
    if (x >= 0) {
      favLocationsList.removeAt(x);
    } else {
      favLocationsList.add(location);
    }
    notifyListeners();
  }
}
