import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:test_qoohoo/constants.dart';
import 'package:test_qoohoo/widgets/record_item.dart';
import 'package:test_qoohoo/widgets/waves.dart';

class Recordings extends StatefulWidget {
  final List<Map> audioPaths;

  Recordings(this.audioPaths);

  @override
  _RecordingsState createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();

  bool _isPlaying = false;

  String path = "";
  late int recordingNo;
  String duration = "";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        path.isEmpty
            ? Container()
            : Container(
                height: mediaQuery.orientation == Orientation.landscape
                    ? mediaQuery.size.height * 0.5
                    : mediaQuery.size.height * 0.3,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage("assets/images/speaker.jpg"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    opacity: 0.05,
                  ),
                  gradient: RadialGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                    focalRadius: 5,
                    radius: 0.7,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: _isPlaying == false
                          ? () async {
                              setState(() {
                                _isPlaying = true;
                              });
                              await _player.play();
                              _player.playlistAudioFinished.listen((event) {
                                setState(() {
                                  _isPlaying = false;
                                });
                              });
                            }
                          : () async {
                              setState(() {
                                _isPlaying = false;
                              });
                              await _player.pause();
                              // _player.playlistAudioFinished.listen((event) {
                              //   setState(() {
                              //     _isPlaying = false;
                              //   });
                              // });
                            },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        color: primaryColor,
                        elevation: 2,
                        surfaceTintColor: secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            _isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 35,
                            color: _isPlaying ? secondaryIconColor : iconColor,
                          ),
                        ),
                      ),
                    ),
                    _isPlaying ? Waves() : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Recording $recordingNo",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "Duration(m:s)  $duration",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
        ListView.builder(
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () async {
                setState(() {
                  if (_isPlaying) {
                    _isPlaying = false;
                  }
                  path = widget.audioPaths[i]["path"];
                  recordingNo = i + 1;
                  duration = widget.audioPaths[i]["duration"];
                });
                await _player.open(
                  Audio.file(path),
                  autoStart: false,
                );
              },
              child: RecordItem(
                player: _player,
                no: i + 1,
                audio: widget.audioPaths[i],
              ),
            );
          },
          itemCount: widget.audioPaths.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
