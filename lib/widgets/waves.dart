import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Waves extends StatelessWidget {
  final Stopwatch? stopwatch;
  final double? height;

  Waves({
    this.stopwatch,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    const _colors = [
      Colors.lightBlueAccent,
      Colors.black,
      Colors.blue,
    ];

    const _durations = [
      3000,
      3500,
      4000,
    ];

    const _heightPercentages = [
      0.65,
      0.66,
      0.67,
    ];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: height == null ? 3 : mediaQuery.size.height * 0.1,
            alignment: Alignment.center,
            child: WaveWidget(
              config: CustomConfig(
                colors: _colors,
                durations: _durations,
                heightPercentages: _heightPercentages,
              ),
              size: const Size(double.infinity, double.infinity),
              isLoop: true,
            ),
          ),
          SizedBox(height: 50),
          stopwatch == null
              ? Container()
              : Text(
                  "${stopwatch!.elapsed.inMinutes}:${stopwatch!.elapsed.inSeconds}",
                  style: const TextStyle(
                    fontSize: 35,
                  ),
                ),
        ],
      ),
    );
  }
}
