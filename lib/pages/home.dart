import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/modules/custom_button.dart';
import 'package:wiki_map/pages/geosearch.dart';
import 'package:wiki_map/pages/settings.dart';
import 'package:wiki_map/providers/map_provider.dart';




class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Map Testing'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));
            },
          ),

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(20, 80, 20, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(20, 20, 20, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 200,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Latitude Here',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 200,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Longitude Here',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.print),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            ChangeNotifierProvider.value(
                                value: MapProvider(),
                                child: Consumer<MapProvider>(
                                  builder: (BuildContext context, MapProvider provider, Widget child){
                                    if(provider.setOfMarkers == null) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return GeoSearch();
                                    }
                                  },
                                )
                            )));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text('Map Testing'),
            ),
          ],
        ),
      ),
    );
  }
}
