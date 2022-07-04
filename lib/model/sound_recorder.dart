import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class AudioRecorder {
  FlutterSoundRecorder? _audioRecorder;

  bool isInit = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final micPermission = await Permission.microphone.request();
    final storagePermission = await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    if (micPermission != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission denied");
    }
    if (storagePermission != PermissionStatus.granted) {
      throw Exception("Storage permission denied");
    }
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
    // print(tmpPath);
    return tmpPath;
  }
}
