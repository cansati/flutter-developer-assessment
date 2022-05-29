import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/constant/route_names.dart';
import 'package:flutter_developer_assessment/view_model/favourites_view_model.dart';
import 'package:provider/provider.dart';
import '../constant/widget_designs.dart';
import '../service/analytics_service.dart';

class FavouritesView extends StatelessWidget {
  AnalyticsService analyticsService = AnalyticsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: context.watch<FavouritesViewModel>().state == FavouritesState.BUSY
            ? buildLoadingWidget()
            : context.watch<FavouritesViewModel>().state ==
                    FavouritesState.ERROR
                ? buildErrorWidget()
                : context
                        .watch<FavouritesViewModel>()
                        .favLocationsList
                        .isNotEmpty
                    ? Stack(
                        children: [
                          buildListView(context),
                          Positioned(
                              bottom: 0, child: goBackContainer(context)),
                        ],
                      )
                    : Stack(
                        children: [
                          buildEmptyText(),
                          Positioned(
                              bottom: 0, child: goBackContainer(context)),
                        ],
                      ));
  }

  Center buildErrorWidget() =>
      const Center(child: Text('Beklenmeyen bir hata gerçekleşti'));

  Center buildEmptyText() => const Center(child: Text('Favoriler boş.'));

  Center buildLoadingWidget() =>
      const Center(child: CircularProgressIndicator());

  Container goBackContainer(context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: InkWell(
              onTap: () async {
                Navigator.of(context).pop();
                await analyticsService.getAnalytics().logEvent(
                    name: "Navigation",
                    parameters: {
                      "from": FavouritesViewRoute,
                      "to": LocationViewRoute
                    });
              },
              child: WidgetHelper().getLoginButtonDesign(context, 40,
                  MediaQuery.of(context).size.width / 2, "Haritaya dön", 20.0)),
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))));
  }

  ListView buildListView(BuildContext context) {
    return ListView.builder(
        itemCount: context.watch<FavouritesViewModel>().favLocationsList.length,
        itemBuilder: (_, index) => buildListItem(context, index));
  }

  Widget buildListItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        horizontalTitleGap: 5,
        minLeadingWidth: 0,
        leading: const Icon(Icons.location_on),
        trailing: GestureDetector(
            onTap: () async {
              await analyticsService
                  .getAnalytics()
                  .logEvent(name: "PlaceRemovedFromFav", parameters: {
                "id": Provider.of<FavouritesViewModel>(context, listen: false)
                    .favLocationsList[index]
                    .id
                    .toInt(),
                "name": Provider.of<FavouritesViewModel>(context, listen: false)
                    .favLocationsList[index]
                    .name
              });
              Provider.of<FavouritesViewModel>(context, listen: false)
                  .addOrPopFavourite(
                      Provider.of<FavouritesViewModel>(context, listen: false)
                          .favLocationsList[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.25,
              child: const Center(
                child: Text(
                  "Kaldır",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            )),
        title: Text(
            context.watch<FavouritesViewModel>().favLocationsList[index].name),
      ),
    );
  }
}
