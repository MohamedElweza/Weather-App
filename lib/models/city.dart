import 'package:the_weather/models/coord.dart';

class City{
  late int id;
  late String name;
  late Coord coord;
  late String country;
  late int population;
  late int timezone;
  late int sunrise;
  late String sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
});
  City.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.coord = Coord.fromMap(map['coord']);
    this.country = map['country'];
    this.population = map['population'];
    this.timezone = map['timezone'];
    this.sunrise = map['sunrise'];
    this.sunset = map['sunset'].toString();
  }
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map ={
     'id': this.id,
     'name' : this.name,
     'coord' : this.coord.toMap(),
     'country' : this.country,
     'population' : this.population,
     'timezone' : this.timezone,
     'sunrise' : this.sunrise,
     'sunset' : this.sunset,
    };
    return map;
  }
}