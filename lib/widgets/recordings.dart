import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:test_qoohoo/widgets/record_item.dart';

class Recordings extends StatefulWidget {
  final List<Map> audioPaths;

  Recordings(this.audioPaths);

  @override
  _RecordingsState createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return RecordItem(
          player: _player,
          no: i + 1,
          audio: widget.audioPaths[i],
        );
      },
      itemCount: widget.audioPaths.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
