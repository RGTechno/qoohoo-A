import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_qoohoo/constants.dart';

class RecordItem extends StatefulWidget {
  final AssetsAudioPlayer player;
  final Map audio;
  final int no;

  RecordItem({
    required this.player,
    required this.no,
    required this.audio,
  });

  @override
  _RecordItemState createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();

  String getDate(String path) {
    int idx = path.lastIndexOf('/');
    String epochNumber = path.substring(idx + 1, path.length);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(epochNumber));
    return "${date.day}/${date.month}/${date.year}";
  }

  bool _isPlaying = false;

  late String date;

  @override
  void initState() {
    // TODO: implement initState
    date = getDate(widget.audio["path"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 4,
      // margin: EdgeInsets.symmetric(vertical: ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor.withOpacity(0.4),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: _isPlaying
            ? mediaQuery.orientation == Orientation.landscape
                ? mediaQuery.size.height * 0.4
                : mediaQuery.size.height * 0.2
            : mediaQuery.orientation == Orientation.landscape
                ? mediaQuery.size.height * 0.2
                : mediaQuery.size.height * 0.1,
        child: Column(
          mainAxisAlignment: _isPlaying
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      _isPlaying = true;
                    });
                    await widget.player.open(
                      Audio.file(widget.audio["path"]),
                      autoStart: true,
                    );

                    widget.player.playlistAudioFinished.listen((event) {
                      setState(() {
                        _isPlaying = false;
                      });
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: primaryColor,
                    elevation: 2,
                    surfaceTintColor: secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 30,
                        color: _isPlaying ? secondaryIconColor : iconColor,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Recording ${widget.no}",
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      "$date",
                      style: TextStyle(
                        color: Color(0xff929eb0),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _isPlaying
                ? AudioWave(
                    height: 50,
                    width: 100,
                    spacing: 2.5,
                    animationLoop: 0,
                    bars: [
                      AudioWaveBar(
                          heightFactor: 0.1, color: Colors.lightBlueAccent),
                      AudioWaveBar(heightFactor: 0.3, color: Colors.blue),
                      AudioWaveBar(heightFactor: 0.7, color: Colors.black),
                      AudioWaveBar(heightFactor: 0.4),
                      AudioWaveBar(
                          heightFactor: 0.1, color: Colors.lightBlueAccent),
                      AudioWaveBar(heightFactor: 0.3, color: Colors.blue),
                      AudioWaveBar(heightFactor: 0.7, color: Colors.black),
                      AudioWaveBar(heightFactor: 0.4),
                      AudioWaveBar(
                          heightFactor: 0.1, color: Colors.lightBlueAccent),
                      AudioWaveBar(heightFactor: 0.3, color: Colors.blue),
                      AudioWaveBar(heightFactor: 0.7, color: Colors.black),
                      AudioWaveBar(heightFactor: 0.4),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
