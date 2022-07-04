import 'package:flutter/material.dart';
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
    String epochNumber = path.substring(idx + 1, path.length - idx);

    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(epochNumber));
    return "${date.day}/${date.month}/${date.year}";
  }

  String date = "";

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      date = getDate(widget.path);
    });
    print("Date $date");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () async {
              await widget.player.play(
                widget.path,
              );
            },
            icon: Icon(
              Icons.play_arrow,
              size: 50,
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Text(
                "Audio ${widget.no}",
                style: TextStyle(
                  color: fontColor,
                ),
              ),
              Text(
                "$date",
                style: TextStyle(
                  color: fontColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
