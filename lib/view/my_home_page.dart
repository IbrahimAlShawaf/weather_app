// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather/controller/weather_api_controller.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/view/todays_weather.dart';

import 'future_forcast_listitem.dart';
import 'hourly_weather_listitem.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService apiService = ApiService();
  String queryText = "auto:ip";
  final _textFieldController = TextEditingController();

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search Location'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "search by city,zip"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    if (_textFieldController.text.isEmpty) {
                      return;
                    }
                    Navigator.pop(context, _textFieldController.text);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Weather App",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              //foreground: Paint()..shader = shader,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                _textFieldController.clear();
                String text = await _showTextInputDialog(context);
                setState(() {
                  queryText = text;
                });
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  queryText = "auto:ip";
                });
              },
              icon: const Icon(
                Icons.my_location_outlined,
                color: Colors.white,
              )),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;

              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // today weather =========>
                    TodayWeather(
                      weatherModel: weatherModel,
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // hourly weather =========>
                    const Text(
                      "Weather By Hours",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),

                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel
                              ?.forecast?.forecastday?[0].hour?[index];

                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                        itemCount: weatherModel
                                ?.forecast?.forecastday?[0].hour?.length ??
                            0,
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // future forcast weather =========>
                    const Text(
                      "Next Days Weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),

                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return FutureForcastListItem(
                            forecastday:
                                weatherModel?.forecast?.forecastday?[index],
                          );
                        },
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        // physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: apiService.getWeatherData(queryText),
        ),
      ),
    );
  }
}
