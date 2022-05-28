import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/view_model/favourites_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/location.dart';

class DetailView extends StatelessWidget {
  FirebaseAnalytics analytics;
  FirebaseAnalyticsObserver observer;
  Location location;

  DetailView(
      {required this.location,
      required this.analytics,
      required this.observer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Text(
                location.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 1,
              ),
              InkWell(
                  child: Text(location.website,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff0000FF),
                        decoration: TextDecoration.underline,
                      )),
                  onTap: () => launchUrl(Uri.parse(location.website),
                      mode: LaunchMode.platformDefault)),
              const Spacer(
                flex: 1,
              ),
              Text(location.open_now ? "Şuan açık" : "Şuan kapalı"),
              const Spacer(
                flex: 2,
              )
            ],
          ),
          IconButton(
            icon: Icon(
                context
                        .watch<FavouritesViewModel>()
                        .favLocationsList
                        .contains(location)
                    ? Icons.star
                    : Icons.star_border_outlined,
                size: 40),
            onPressed: () async {
              await analytics.logEvent(name: "FavAddedOrRemoved", parameters: {
                "id": location.id.toInt(),
                "name": location.name
              });
              context.read<FavouritesViewModel>().addOrPopFavourite(location);
            },
          )
        ],
      ),
    );
  }
}
