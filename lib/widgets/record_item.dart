import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
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
            ),
          ),
          Text("Audio ${widget.no}")
        ],
      ),
    );
  }
}
