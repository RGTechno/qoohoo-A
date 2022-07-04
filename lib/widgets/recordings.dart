import 'package:flutter/material.dart';
import 'package:test_qoohoo/widgets/record_item.dart';

import '../model/sound_player.dart';

class Recordings extends StatefulWidget {
  final List<String> audioPaths;

  Recordings(this.audioPaths);

  @override
  _RecordingsState createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
  AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    _player.init();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return RecordItem(
          player: _player,
          no: i + 1,
          path: widget.audioPaths[i],
        );
      },
      itemCount: widget.audioPaths.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
