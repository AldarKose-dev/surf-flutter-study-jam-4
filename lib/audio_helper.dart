// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/services.dart';

// class AudioHelper {
//   static final AudioCache _audioCache = AudioCache(prefix: 'audio/');
//   static final player = AudioPlayer();
//   void toByteData() async {
//     String audioasset = "assets/audio/red-indian-music.mp3";
//     ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
//     Uint8List audiobytes =
//         bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//   }
//   // static Future<void> playSuccessSound() async {
//   //   await _playSound('success.mp3');
//   // }

//   // static Future<void> playErrorSound() async {
//   //   await _playSound('error.mp3');
//   // }

//   // static Future<void> _playSound(String soundFilename) async {
//   //   try {
//   //     await player.play(soundFilename);
//   //   } catch (error) {
//   //     debugPrint('Error playing sound: $error');
//   //   }
//   // }
// }
