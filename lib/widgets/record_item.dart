import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_qoohoo/constants.dart';
import 'package:test_qoohoo/model/sound_player.dart';

class RecordItem extends StatefulWidget {
  final AudioPlayer player;
  final String path;
  final int no;

  RecordItem({
    required this.player,
    required this.no,
    required this.path,
  });

  @override
  _RecordItemState createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  String getDate(String path) {
    int idx = path.lastIndexOf('/');
    String epochNumber = path.substring(idx + 1, path.length);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(epochNumber));
    return "${date.day}/${date.month}/${date.year}";
  }

  late String date;

  @override
  void initState() {
    // TODO: implement initState
    date = getDate(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await widget.player.play(
                  widget.path,
                );
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
                    Icons.play_arrow_rounded,
                    size: 30,
                    color: iconColor,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
