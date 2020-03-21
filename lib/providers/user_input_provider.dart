import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
Created NB 3/21/2020

This provider class stores the data and logic for the the TextField widgets in the Home (home.dart) class.
The listener is initialized in the widget tree in the app.dart file with the lines:
  providers: [
        ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider(themeProvider)),
        ChangeNotifierProvider<UserInputProvider>(create: (_) => UserInputProvider())
      ],
Multiple Providers can be created at the same time in the widget tree like this, you can see that-
it is also initializing the SettingsProvider class
 */
class UserInputProvider with ChangeNotifier{

  //member variables
  CameraPosition _startingLocation;
  TextEditingController _latitudeController;   //2 different are controllers are-
  TextEditingController _longitudeController;  //needed for 2 TextField widgets (home.dart)
  double _inputLatitude;  //stores the current double value of each TextField
  double _inputLongitude;

  //member variable get functions
  CameraPosition get startingLocation => _startingLocation;
  TextEditingController get latitudeController => _latitudeController;
  TextEditingController get longitudeController => _longitudeController;
  double get inputLatitude => _inputLatitude;
  double get inputLongitude => _inputLongitude;

  //class constructor, what is ran when the class is initialized from the widget tree (app.dart)
  UserInputProvider() {
    _longitudeController = TextEditingController();
    _latitudeController = TextEditingController();
  }

  //member variable set methods
  void setStartingLocation(double inputLatitude, double inputLongitude) {
    _startingLocation = CameraPosition(target: LatLng(inputLatitude, inputLongitude), zoom: 13); //TODO make zoom dynamic based on distance of furthest marker
    //doesn't need to notify listeners because
  }
  void setInputLatitude(double inputLatitude) {
    print('SETINPUTLATITUDE CALLED ' + inputLatitude.toString());
    _inputLatitude = inputLatitude;
    notifyListeners();
  }
  void setInputLongitude(double inputLongitude) {
    print('SETINPUTLONGITUDE CALLED ' + inputLongitude.toString());
    _inputLongitude = inputLongitude;
    notifyListeners();
  }

  //TODO do I need this function here?
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

}