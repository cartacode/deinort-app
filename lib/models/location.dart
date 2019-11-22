
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
      latitude: json['latt'], 
      longitude: json['longt'], 
      address: json['staddress'],
      zipcode: json['zipcode'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  factory UserLocation.fromReverseJson(Map<String,dynamic> json) {
    if (json.containsKey('alt')) {
      return UserLocation(
        latitude: json['latt'], 
        longitude: json['longt'], 
        address: json['alt']['loc']['staddress'],
        zipcode: json['alt']['loc']['postal'],
        city: json['alt']['loc']['city'],
        state: json['alt']['loc']['state'],
        country: json['alt']['loc']['country'],
      );
    } else {
      throw Exception('Failed to load data!');
    }

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

  static Resource<UserLocation> get searchByCity {
    return Resource(
      url: Constants.GEOCODE_DEMO_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        return UserLocation.fromReverseJson(result);
      }
    );
  }

}