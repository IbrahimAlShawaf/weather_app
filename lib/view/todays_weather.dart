import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class TodayWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodayWeather({
    Key? key,
    this.weatherModel,
  }) : super(key: key);

  // Weather Type
  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    }
    return WeatherType.middleRainy;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: getWeatherType(weatherModel?.current),
          width: MediaQuery.of(context).size.width,
          height: 280,
        ),
        SizedBox(
          width: double.infinity,
          //padding: EdgeInsets.all(8),
          height: 280,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white10,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(10))),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withRed(150),
                        // foreground: Paint()..shader = shader,
                      ),
                    ),
                    Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.parse(
                            weatherModel?.current?.lastUpdated.toString() ??
                                "")),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withRed(100),
                          //foreground: Paint()..shader = shader,
                        )),
                  ],
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          "https:${weatherModel?.current?.condition?.icon ?? ""}",
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              weatherModel?.current?.tempC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                          ),
                          const Text(
                            'o',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink
                                //foreground: Paint()..shader = shader,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withRed(150),
                          //foreground: Paint()..shader = shader,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  //Spacer()
                ],
              ),
              // const Spacer(),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Feel Like",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withBlue(100),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                weatherModel?.current?.feelslikeC
                                        ?.round()
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.red.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Wind",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "${weatherModel?.current?.windKph?.round()} km/h",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.red.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Humidity",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                            Text("${weatherModel?.current?.humidity}%",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.red.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Visibility",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                            Text("${weatherModel?.current?.visKm?.round()} km",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.red.withBlue(100),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 8,
        // ),
      ],
    );
  }
}
