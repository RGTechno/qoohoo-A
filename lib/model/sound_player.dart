import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayer {
  late AssetsAudioPlayer _audioPlayer;

  bool isInit = false;

  Future init() async {
    _audioPlayer = AssetsAudioPlayer();
    isInit = true;
  }

  void dispose() {
    isInit = false;
  }

  Future play(String filePath) async {
    if (!isInit) return;

    await _audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
    );
  }

  Future stop() async {
    if (!isInit) return;
    await _audioPlayer.stop();
  }

  Future<bool> getStatus() async {
    return _audioPlayer.isPlaying.value;
  }
}
