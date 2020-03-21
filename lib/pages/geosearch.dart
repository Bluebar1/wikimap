import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/pages/wiki_search_results.dart';
import 'package:wiki_map/providers/map_provider.dart';
import 'package:wiki_map/providers/user_input_provider.dart';
import 'package:wiki_map/providers/wiki_article_provider.dart';

class GeoSearch extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
        body: GoogleMap(
          markers: mapProvider.setOfMarkers,
          mapType: MapType.normal,
          initialCameraPosition: mapProvider.startingCameraPosition,//userInputProvider.startingLocation,
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
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(208, 208, 208, 0),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(30),
                                topRight: const Radius.circular(30),
                              ),
                            ),
                            child: ChangeNotifierProvider<WikiArticleProvider>(
                              create: (context) => WikiArticleProvider(mapProvider),
                              child: Consumer<WikiArticleProvider>(
                                builder: (context, wikiProvider, child){
                                  if(wikiProvider.imageUrlList == null && wikiProvider.summaryList == null) { //TODO switch this to or '||' and get rid of Future.wait method in WikiProvider
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else {
                                    return WikiSearchResults();
                                  }
                                },
                              ),
                            ),
                          );
                        }
                    );
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
        )
    );
  }
}