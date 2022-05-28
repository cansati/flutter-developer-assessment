import 'dart:convert';

List<Location> locationFromJson(List<Map<String, dynamic>> str) {
  List<Location> locationList = [];
  try {
    return List<Location>.from(str.map((x) {
      return Location.fromJson(x);
    }));
  } catch (e) {
    print(e);
  }
  return locationList;
}

String locationToJsonString(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  int id;
  double lat;
  double lon;
  String name;
  bool open_now;
  String website;

  Location(
      {required this.id,
      required this.lat,
      required this.lon,
      required this.name,
      required this.open_now,
      required this.website});

  factory Location.fromJson(Map<String, dynamic> json) {
    int x = int.parse(json["id"]);
    return Location(
      id: x,
      lat: json["lat"] as double,
      lon: json["lon"] as double,
      name: json["name"] as String,
      open_now: json["open_now"] as bool,
      website: json["website"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lon": lon,
        "name": name,
        "open_now": open_now,
        "website": website
      };
}
