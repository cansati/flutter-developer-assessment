import 'dart:async';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/view/auth_view.dart';
import 'package:flutter_developer_assessment/view_model/auth_view_model.dart';
import 'package:flutter_developer_assessment/view_model/favourites_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'view/location_view.dart';
import 'view_model/location_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runZonedGuarded(
      () => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthViewModel()),
              ChangeNotifierProvider(create: (_) => LocationViewModel()),
              ChangeNotifierProvider(create: (_) => FavouritesViewModel()),
            ],
            child: MyApp(),
          )),
      FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  var storage = FlutterSecureStorage();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<String> _jwtOrEmpty(BuildContext context) async {
    var tokenOrNull = await storage.read(key: "jwt");
    if (tokenOrNull == null) return "";
    try {
      await storage.write(key: "jwt", value: tokenOrNull);
      context.read<AuthViewModel>().updateToken(tokenOrNull);
    } catch (e) {
      print(e);
    }
    return tokenOrNull;
  }

  bool _isTokenUpToDate(List jwt) {
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
    return DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
        .isAfter(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorObservers: <NavigatorObserver>[observer],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _jwtOrEmpty(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: const CircularProgressIndicator())
                    ],
                  ),
                );
              }
              if (snapshot.data == "") {
                return AuthView(analytics: analytics, observer: observer);
              } else {
                var str = snapshot.data.toString();
                var jwt = str.split(".");
                if (jwt.length == 3) {
                  if (_isTokenUpToDate(jwt)) {
                    return LocationView(
                        analytics: analytics, observer: observer);
                  } else {
                    return AuthView(analytics: analytics, observer: observer);
                  }
                } else {
                  return AuthView(analytics: analytics, observer: observer);
                }
              }
            }));
  }
}
