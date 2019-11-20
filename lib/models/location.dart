
import 'dart:convert';
import 'package:deinort_app/services/webservice.dart';
import 'package:deinort_app/utils/constants.dart';

class UserLocation {
  
  final String latitude; 
  final String longitude; 
  final String address;
  final String zipcode;
  final String city;
  final String state;
  final String country;

  UserLocation({this.latitude, this.longitude, this.address, this.zipcode, this.city,
            this.state, this.country});

  factory UserLocation.fromJson(Map<String,dynamic> json) {
    return UserLocation(
      latitude: json['latitude'], 
      longitude: json['longitude'], 
      address: json['address'] ?? '',
      zipcode: json['zipcode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );

  }

  static Resource<UserLocation> get info {
    
    return Resource(
      url: Constants.GEOCODE_DEMO_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        return UserLocation.fromJson(result);
      }
    );

  }

  String getState() => this.state;
}