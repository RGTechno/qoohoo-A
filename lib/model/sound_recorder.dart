import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder {
  FlutterSoundRecorder? _audioRecorder;

  bool isInit = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future<bool> micPermissions() async {
    final micPermission = await Permission.microphone.request();
    if (micPermission.isDenied == true ||
        micPermission.isPermanentlyDenied == true) {
      micPermissions();
    }
    return true;
  }

  Future<bool> storagePermissions() async {
    final storagePermission = await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    if (storagePermission.isDenied == true ||
        storagePermission.isPermanentlyDenied == true) {
      storagePermissions();
    }
    return true;
  }

  Future<bool> askPermissions() async {
    final micStatus = await micPermissions();
    final storageStatus = await storagePermissions();
    if (micStatus == false && storageStatus == false) {
      askPermissions();
    }
    return true;
  }

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    askPermissions();
    await _audioRecorder?.openRecorder();
    isInit = true;
  }

  void dispose() {
    _audioRecorder?.closeRecorder();
    _audioRecorder = null;
    isInit = false;
  }

  Future record(String filePath) async {
    if (!isInit) return;
    await _audioRecorder?.startRecorder(toFile: filePath);
  }

  Future<String?> stop() async {
    if (!isInit) return null;
    String? tmpPath = await _audioRecorder?.stopRecorder();
    return tmpPath;
  }
}
