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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Text(
              formatter.format(date),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
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
              DateTime parsedDateTime =
                  DateTime.parse(response.list.first.dt_txt);
              String formatDate =
                  DateFormat("yyyy-MM-dd").format(parsedDateTime);
              List tp = response.list;
              List daily = [];
              tp.forEach((element) {
                if (daily.contains(formatDate)) {
                } else {
                  daily.add(element);
                  // print(date);
                }
              });
              // print(date);
              print(daily.toString());

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
                                      child: Text('Search'))),
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
                      SizedBox(
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
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.blueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Column(children: [
                                Row(
                                  children: dates
                                      .map((widget) => Expanded(child: widget))
                                      .toList(),
                                ),
                              ]),
                            ],
                          ),
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
