import 'package:the_weather/models/singleForcastRead.dart';
import 'package:the_weather/models/weatherdes.dart';

import 'city.dart';

class WeatherApiResponse{

  late String cod;
  late int message;
  late int cnt;
  late List<SingleforcastRead> list;
  late City city;


  WeatherApiResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
});

  WeatherApiResponse.fromMap(Map<String, dynamic> map){
    this.cod = map['cod'];
    this.message = map['message'];
    this.cnt = map['cnt'];
    this.list =[];
    (map['list'] as List).forEach((element) {
      this.list.add(SingleforcastRead.fromMap(element));
    });
    this.city = City.fromMap(map['city']);
  }
  Map<String,dynamic> toMap(){
    List<Map> tmplist =[];
    this.list.forEach((element) {
      tmplist.add(element.toMap());
    });
    Map<String,dynamic> map={
    "cod" : this.cod ,
    "message" : this.message,
    'cnt' : this.cnt,
    'list': tmplist,
    'city': this.city.toMap(),
    };
    return map;
  }

}