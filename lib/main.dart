import 'package:flutter/material.dart';
import 'package:the_weather/api/api.dart';
import 'package:the_weather/models/weather_apiResponse.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WeatherApiResponse response;
  final weatherApi = WeatherApi();
  String city = 'cairo';

  void search() async {
    final _response = await weatherApi.getApiData(city);
    setState(() => response = _response);

    @override
    void initState() {
      super.initState();
      weatherApi.getApiData(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime d = DateTime.now();
    DateFormat formatter = DateFormat("EEE");
    final dates = <Widget>[];

    for (int i = 0; i < 5; i++) {
      final date = d.add(Duration(days: i));
      dates.add(Padding(
        padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 20.0,
            right: 20.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                formatter.format(date),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            // Text(_monthFormatter.format(date)),
          ],
        ),
      ));
    }
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<WeatherApiResponse>(
          future: weatherApi.getApiData(city),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              response = snapShot.data!;
              // DateTime parsedDateTime =
              //     DateTime.parse(response.list.first.dt_txt);
              // String formatDate =
              //     DateFormat("yyyy-MM-dd").format(parsedDateTime);
              // List tp = response.list;
              // List daily = [];
              // tp.forEach((element) {
              //   if (daily.contains(formatDate)) {
              //   } else {
              //     daily.add(element);
              //     // print(date);
              //   }
              // });
              // // print(date);
              // // print(daily.toString());

              return SingleChildScrollView(
                child: Container(
                  color: Colors.blueAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 70, right: 50, left: 50, bottom: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) => city = value,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'City',
                                    filled: true, //<-- SEE HERE
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: search,
                                      child: const Text('Search'))),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        response.city.name,
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.network(
                          'https://openweathermap.org/img/wn/${response.list.first.weather.first.icon}@2x.png'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${response.list.first.main.temp}°',
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Text(
                        response.list.first.weather.first.description,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.blueAccent,
                        child: Column(
                          children: [
                            Column(children: [
                              const SizedBox(height: 30,),
                              Row(
                                children: dates
                                    .map((widget) => Expanded(child: widget))
                                    .toList(),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(

                                      children: [
                                        Column(
                                          children: [
                                            Image.network(
                                                'https://openweathermap.org/img/wn/${response.list.elementAt(0).weather.first.icon}@2x.png'),
                                            Text(
                                              response.list
                                                  .elementAt(0)
                                                  .main
                                                  .temp
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.network(
                                                'https://openweathermap.org/img/wn/${response.list.elementAt(8).weather.first.icon}@2x.png'),
                                            Text(
                                              response.list
                                                  .elementAt(8)
                                                  .main
                                                  .temp
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.network(
                                                'https://openweathermap.org/img/wn/${response.list.elementAt(16).weather.first.icon}@2x.png'),
                                            Text(
                                              response.list
                                                  .elementAt(16)
                                                  .main
                                                  .temp
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.network(
                                                'https://openweathermap.org/img/wn/${response.list.elementAt(24).weather.first.icon}@2x.png'),
                                            Text(
                                              response.list
                                                  .elementAt(24)
                                                  .main
                                                  .temp
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.network(
                                                'https://openweathermap.org/img/wn/${response.list.elementAt(32).weather.first.icon}@2x.png'),
                                            Text(
                                              response.list
                                                  .elementAt(32)
                                                  .main
                                                  .temp
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapShot.hasError) {
              print(snapShot.error);
              return Container();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
