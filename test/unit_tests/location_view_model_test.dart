import 'package:flutter_developer_assessment/model/location.dart';
import 'package:flutter_developer_assessment/service/auth_service.dart';
import 'package:flutter_developer_assessment/view_model/auth_view_model.dart';
import 'package:flutter_developer_assessment/view_model/favourites_view_model.dart';
import 'package:flutter_developer_assessment/view_model/location_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:io' show File;

void main() {
  test('location-state', () {
    LocationViewModel locationViewModel = LocationViewModel();

    locationViewModel.locationState(LocationState.IDLE);
    expect(locationViewModel.state, LocationState.IDLE);
    locationViewModel.locationState(LocationState.BUSY);
    expect(locationViewModel.state, LocationState.BUSY);
    locationViewModel.locationState(LocationState.ERROR);
    expect(locationViewModel.state, LocationState.ERROR);
  });

  test('fetch-locations', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    LocationViewModel locationViewModel = LocationViewModel();

    //Trying to fetch locations by incorrect token
    locationViewModel.fetchLocations("incorrect-token");
    expect(locationViewModel.locationList.isEmpty, true);

    //IF YOU WANT TO FETCH LOCATIONS SUCCESSFULLY ENTER CORRECT CREDENTIALS;
    //ALSO TO ACHIEVE TO GET THE TOKEN, RUN THIS TEST FILE BY THE COMMAND BELOW;
    //flutter run test/unit_tests/location_view_model_test.dart
    //It is because this should execute your test "in your preferred runtime environment such as a simulator or a device."
    //Inside the AuthService().loginWithService there is FlutterSecureStorage initializing, within our test environment it is not going to be initialized and try-catch blocks gonna throw an exception

    /*
    String username = "ENTER_CORRECT_USERNAME";
    String password = "ENTER_CORRECT_PASSWORD";
    String token = "";

    token = await AuthService().loginWithService(username, password);

    //Trying to fetch locations by correct token
    await locationViewModel.fetchLocations(token);
    expect(locationViewModel.locationList.isNotEmpty, true);
    */
  });
}
