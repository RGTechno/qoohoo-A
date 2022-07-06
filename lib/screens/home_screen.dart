import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_qoohoo/constants.dart';
import 'package:test_qoohoo/model/sound_recorder.dart';
import 'package:test_qoohoo/widgets/recordings.dart';
import 'package:test_qoohoo/widgets/waves.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stopwatch = Stopwatch();

  List<Map> audioFilePaths = [];

  AudioRecorder _recorder = AudioRecorder();

  late Timer timer;

  bool isRecording = false;

  Future<String?> getPath() async {
    Directory? appDocDir = await getExternalStorageDirectory();
    String? appDocPath = appDocDir?.path;
    String? filePath =
        appDocPath! + '/' + DateTime.now().millisecondsSinceEpoch.toString();

    return filePath;
  }

  @override
  void initState() {
    // TODO: implement initState
    _recorder.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _recorder.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      // backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(0.7),
                secondaryColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp,
            ),
          ),
          height: mediaQuery.size.height,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: isRecording
                    ? Waves(stopwatch: stopwatch,height: 100)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/logoq.png",
                                  fit: BoxFit.cover,
                                  height: 40,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Latest Recordings",
                                  style: TextStyle(
                                    color: fontColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.03),
                          audioFilePaths.length == 0
                              ? Center(
                                  child: Text(
                                    "Hey! Go on record your first audio!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              : Recordings(audioFilePaths),
                        ],
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onLongPressStart: (LongPressStartDetails det) async {
                    stopwatch.start();
                    setState(() {
                      isRecording = true;
                    });
                    if (isRecording) {
                      timer = Timer.periodic(Duration(milliseconds: 10), (_) {
                        setState(() {});
                      });
                    }
                    String? newPath = await getPath();
                    await _recorder.record(newPath!);
                  },
                  onLongPressEnd: (LongPressEndDetails det) async {
                    stopwatch.stop();
                    String? path = await _recorder.stop();
                    if (path != null) {
                      audioFilePaths.add({
                        "path": path,
                        "duration":
                            "${stopwatch.elapsed.inMinutes.toString()}:${stopwatch.elapsed.inSeconds.toString()}"
                      });
                    }
                    timer.cancel();
                    stopwatch.reset();
                    setState(() {
                      isRecording = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: isRecording
                          ? Border.all(
                              color: buttonColor,
                              width: 5,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: secondaryColor,
                          spreadRadius: 7,
                          blurRadius: 21,
                          offset: Offset(1, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.mic,
                      size: 35,
                      color: iconColor,
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
