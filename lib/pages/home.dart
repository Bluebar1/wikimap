import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_map/modules/custom_button.dart';
import 'package:wiki_map/pages/geosearch.dart';
import 'package:wiki_map/pages/settings.dart';
import 'package:wiki_map/providers/map_provider.dart';
import 'package:wiki_map/providers/user_input_provider.dart';




class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInputProvider = Provider.of<UserInputProvider>(context);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(20, 80, 20, 1),
              ),
            ),

             */
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
                        controller: userInputProvider.latitudeController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Latituude Here',
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (String value) {
                          var tempVal = double.parse(value);
                          userInputProvider.setInputLatitude(tempVal);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 200,
                      child: TextField(
                        controller: userInputProvider.longitudeController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Longitude Here',
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (String value) {
                          var tempVal = double.parse(value);
                          userInputProvider.setInputLongitude(tempVal);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.print),
                      onPressed: () {
                        userInputProvider.setStartingLocation(userInputProvider.inputLatitude, userInputProvider.inputLongitude);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            ChangeNotifierProvider.value(
                                value: MapProvider(userInputProvider.inputLatitude, userInputProvider.inputLongitude),
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
