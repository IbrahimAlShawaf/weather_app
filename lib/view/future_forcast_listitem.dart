import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/weather_model.dart';

class FutureForcastListItem extends StatelessWidget {
  final Forecastday? forecastday;

  const FutureForcastListItem({Key? key, required this.forecastday})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Image.network("https:${forecastday?.day?.condition?.icon ?? ""}"),
          Expanded(
            child: Text(
              DateFormat.MMMEd()
                  .format(DateTime.parse(forecastday?.date.toString() ?? "")),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
              child: Text(forecastday?.day?.condition?.text ?? "",
                  style: const TextStyle(color: Colors.white))),
          Expanded(
              child: Text(
                  "^${forecastday?.day?.maxtempC?.round()}/${forecastday?.day?.mintempC?.round()}",
                  style: const TextStyle(color: Colors.white, fontSize: 16))),
        ],
      ),
    );
  }
}
