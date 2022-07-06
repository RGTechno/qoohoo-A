import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Waves extends StatelessWidget {
  final Stopwatch stopwatch;

  Waves(this.stopwatch);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const _backgroundColor = Color(0xFFF15BB5);

    const _colors = [
      Colors.black,
      Colors.pink,
    ];

    const _durations = [
      5000,
      4000,
    ];

    const _heightPercentages = [
      0.65,
      0.66,
    ];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: mediaQuery.size.height * 0.1,
            alignment: Alignment.center,
            child: WaveWidget(
              config: CustomConfig(
                colors: _colors,
                durations: _durations,
                heightPercentages: _heightPercentages,
              ),
              size: Size(double.infinity, double.infinity),
              isLoop: true,
            ),
          ),
          SizedBox(height: 50),
          Text(
            stopwatch.elapsed.inMinutes.toString() +
                ":" +
                stopwatch.elapsed.inSeconds.toString(),
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }
}
