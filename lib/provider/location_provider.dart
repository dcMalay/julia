import 'package:flutter/widgets.dart';
import 'package:julia/data/model/city_model.dart';
import 'package:julia/data/model/location_model.dart';
import 'package:julia/data/repository/get_city_repo.dart';
import 'package:julia/data/repository/get_location_repo.dart';

class LocationProvider extends ChangeNotifier {
  List<Location> getlocation = [];
  List<String> data = [];
  // List<City> cityLocation = [];
  List<String> cityData = [];

  getCityName(String locationId) async {
    try {
      cityData = await getcity(locationId);
      print('locationProvider citydata ---->$cityData');
      // for (var i = 0; i < getlocation.length; i++) {
      //   cityData.add(cityLocation[i].cityName);

      //   print('locationProvider citydata ---->$cityLocation');
      // }
    } catch (e) {
      // print('locationProvider citydata ---->$cityData');
      print("locationprovider error -----> $e");
    }
    notifyListeners();
  }

  getallLocation() async {
    try {
      getlocation = await getLocation();
      for (var i = 0; i < getlocation.length; i++) {
        data = [getlocation[i].locationName];

        print('locationProvider data ---->${getlocation[i].locationName}');
        print(data);
      }
    } catch (e) {
      print("locationprovider error -----> $e");
    }
    notifyListeners();
  }
}
