import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_qoohoo/constants.dart';
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
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Latest Recordings",
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Recordings(audioFilePaths),
                ],
              ),
              // Text(
              //   stopwatch.elapsed.inSeconds.toString() +
              //       ":" +
              //       stopwatch.elapsed.inMilliseconds.toString(),
              //   style: TextStyle(
              //     fontSize: 35,
              //   ),
              // ),
              Positioned(
                bottom: 0,
                right: 0,
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.mic,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
