import 'package:flutter_developer_assessment/model/location.dart';
import 'package:flutter_developer_assessment/view_model/favourites_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:io' show File;

void main() {
  test('add-or-pop-favourite', () {
    FavouritesViewModel favouritesViewModel = FavouritesViewModel();

    final location = Location(
        id: 1, lat: 0.0, lon: 0.0, name: "", open_now: true, website: "");

    //Adding the location to the favourites
    favouritesViewModel.addOrPopFavourite(location);
    //Expecting there has to be an object in the favLocationsList
    expect(favouritesViewModel.favLocationsList.isNotEmpty, true);

    //Popping out the location from the favourites
    favouritesViewModel.addOrPopFavourite(location);
    //Expecting there has not to be an object in the favLocationsList
    expect(favouritesViewModel.favLocationsList.isEmpty, true);
  });
}
