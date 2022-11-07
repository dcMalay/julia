import 'package:flutter/widgets.dart';
import 'package:julia/data/model/dynamic_city_model.dart';
import 'package:julia/data/model/location_model.dart';
import 'package:julia/data/repository/get_city_repo.dart';
import 'package:julia/data/repository/get_location_repo.dart';

class LocationProvider extends ChangeNotifier {
  List<Location> getlocation = [];
  List<String> data = [];
  List<City> cityLocation = [];
  List<String> cityData = [];
  getallLocation() async {
    try {
      getlocation = await getLocation();
      for (var i = 0; i < getlocation.length; i++) {
        data.addAll([getlocation[i].locationName]);

        print('locationProvider data ---->${getlocation[i].locationName}');
      }
    } catch (e) {
      print("locationprovider error -----> $e");
    }
  }
}
