import 'package:flutter/cupertino.dart';

class Coord{
  late double lat;
  late double lon;

  Coord({
    required this.lat,
    required this.lon,
});

Coord.fromMap(Map<String,dynamic> map){
  this.lat= map['lat'];
  this.lon= map['lon'];
}

Map<String, dynamic> toMap(){
  return {
    'lat' : this.lat,
     'lon' : this.lon,
  };
}


}