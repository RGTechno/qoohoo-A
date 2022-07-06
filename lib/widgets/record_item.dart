import 'package:assets_audio_player/assets_audio_player.dart';
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

  late String date;

  @override
  void initState() {
    date = getDate(widget.audio["path"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
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
          borderRadius: const BorderRadius.only(
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
        height: mediaQuery.orientation == Orientation.landscape
            ? mediaQuery.size.height * 0.2
            : mediaQuery.size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: primaryColor,
                  elevation: 2,
                  surfaceTintColor: secondaryColor,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.radio,
                      size: 25,
                      color: iconColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Recording ${widget.no}",
                      style: const TextStyle(
                        color: fontColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Color(0xff929eb0),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
