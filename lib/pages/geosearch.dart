import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/wiki_article_list_v3.dart';
import 'package:wiki_map/providers/map_provider.dart';
import 'package:wiki_map/providers/wiki_article_provider.dart';

class GeoSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
        body: GoogleMap(
          markers: mapProvider.setOfMarkers,
          mapType: MapType.normal,
          initialCameraPosition: mapProvider
              .startingCameraPosition, //userInputProvider.startingLocation,
          onMapCreated: (GoogleMapController controller) {
            mapProvider.controller.complete(controller);
          },
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton.extended(
                  heroTag: "articlebutton",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: WikiArticleProvider(mapProvider),
                            child: Consumer<WikiArticleProvider>(
                              builder: (BuildContext context,
                                  WikiArticleProvider provider, Widget child) {
                                if (provider.imageUrlList == null &&
                                    provider.summaryList == null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return WikiArticleListV3();
                                }
                              },
                            ))));
                  },
                  label: Text('View Wiki Pages'),
                  icon: Icon(Icons.directions_boat),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                heroTag: "exitbutton",
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: Text('Exit Map View'),
                icon: Icon(Icons.directions_boat),
              ),
            ),
          ],
        ));
  }
}
