import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/constant/route_names.dart';
import 'package:flutter_developer_assessment/service/analytics_service.dart';
import 'package:flutter_developer_assessment/view/favourites_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../constant/widget_designs.dart';
import '../model/location.dart';
import '../view_model/location_view_model.dart';
import 'detail_view.dart';

class LocationView extends StatefulWidget {
  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  void _onMapCreated(GoogleMapController _googleMapController) {
    setState(() {});
  }

  //Google map variables start
  Set<Marker> _markers = Set();
  Map latLongMap = {};
  late double latitude;
  late double longitude;
  //Google map variables end
  AnalyticsService analyticsService = AnalyticsService();
  FlutterSecureStorage storage = FlutterSecureStorage();
  LocationViewModel locationViewModel = LocationViewModel();
  late List<Location> locationList = [];
  String? token = "";

  Future<void> _sendAnalytics() async {
    await analyticsService
        .getAnalytics()
        .setCurrentScreen(screenName: LocationViewRoute)
        .onError((error, stackTrace) => null);
  }

  @override
  void initState() {
    _sendAnalytics();
    getTokenFetchLocations();
    super.initState();
  }

  Future<void> getTokenFetchLocations() async {
    try {
      token = await storage.read(key: "jwt");
      locationList = await LocationViewModel().fetchLocations(token!);
      context.read<LocationViewModel>().locationState(LocationState.IDLE);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: context.watch<LocationViewModel>().state == LocationState.BUSY
            ? buildLoadingWidget()
            : context.watch<LocationViewModel>().state == LocationState.ERROR
                ? buildErrorWidget()
                : buildMap());
  }

  Center buildErrorWidget() =>
      const Center(child: Text('Beklenmeyen bir hata gerçekleşti'));

  Center buildLoadingWidget() =>
      const Center(child: CircularProgressIndicator());

  Widget buildMap() {
    locationList.forEach((element) {
      _markers.add(Marker(
          onTap: () async {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              context: context,
              builder: (BuildContext context) {
                return DetailView(location: element);
              },
            );
            await analyticsService.getAnalytics().logEvent(
                name: "LocationSelected",
                parameters: {"id": element.id.toInt(), "name": element.name});
          },
          infoWindow: InfoWindow(title: element.name),
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.lat, element.lon)));
    });
    return Stack(children: [
      Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            //myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    locationList.isNotEmpty ? locationList[0].lat : 39.925018,
                    locationList.isNotEmpty ? locationList[0].lon : 32.836956),
                zoom: 10.0),
          )),
      Positioned(
          right: 10,
          top: 40,
          child: InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavouritesView()));
                await analyticsService.getAnalytics().logEvent(
                    name: "Navigation",
                    parameters: {
                      "from": LocationViewRoute,
                      "to": FavouritesViewRoute
                    });
              },
              child: WidgetHelper().getLoginButtonDesign(context, 35,
                  MediaQuery.of(context).size.width / 5, "Favoriler", 15)))
    ]);
  }
}
