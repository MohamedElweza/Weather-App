class WeatherDes{
  late int id;
  late String main;
  late String description;
  late String icon;

  WeatherDes({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
});
  WeatherDes.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.main = map['main'];
    this.description = map['description'];
    this.icon = map['icon'];
  }
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map={
      'id' : this.id,
      'main' : this.main,
      'description' : this.icon,
      'icon' : this.icon,
    };
    return map;
  }
}