import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_qoohoo/model/sound_player.dart';
import 'package:test_qoohoo/model/sound_recorder.dart';
import 'package:test_qoohoo/widgets/recordings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stopwatch = Stopwatch();

  List<String> audioFilePaths = [];

  AudioRecorder _recorder = AudioRecorder();
  AudioPlayer _player = AudioPlayer();

  late Timer timer;

  Future<String?> getPath() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String? appDocPath = appDocDir?.path;
    String? filePath =
        appDocPath! + '/' + DateTime.now().microsecondsSinceEpoch.toString();

    return filePath;
  }

  @override
  void initState() {
    // TODO: implement initState
    _recorder.init();
    _player.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _recorder.dispose();
    timer.cancel();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Recordings(audioFilePaths),
          // Text(
          //   stopwatch.elapsed.inSeconds.toString() +
          //       ":" +
          //       stopwatch.elapsed.inMilliseconds.toString(),
          //   style: TextStyle(
          //     fontSize: 35,
          //   ),
          // ),
          Center(
            child: GestureDetector(
              onLongPressStart: (LongPressStartDetails det) async {
                stopwatch.start();
                // timer = Timer.periodic(Duration(milliseconds: 1), (_) {
                //   setState(() {});
                // });
                String? newPath = await getPath();
                await _recorder.record(newPath!);
              },
              onLongPressEnd: (LongPressEndDetails det) async {
                stopwatch.stop();
                String? path = await _recorder.stop();
                if (path != null) {
                  audioFilePaths.add(path);
                }
                print(stopwatch.elapsed.inSeconds.toString() +
                    ":" +
                    stopwatch.elapsed.inMilliseconds.toString());
                stopwatch.reset();
                setState(() {});
              },
              child: Icon(
                Icons.mic,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
