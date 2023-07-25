import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shake/shake.dart';
import 'package:surfpracticemagicball/dio_exception.dart';
import 'package:surfpracticemagicball/dio_repository.dart';
import 'package:surfpracticemagicball/presentation/cubit/magic_ball_state.dart';

class MagicBallCubit extends Cubit<MagicBallState> {
  late ShakeDetector detector;

  MagicBallCubit() : super(const MagicBallState()) {
    // Initialize shake detector with autoStart
    detector = ShakeDetector.autoStart(
      shakeThresholdGravity: 1.5,
      minimumShakeCount: 1,
      onPhoneShake: () {
        fetchAnswer(); // When phone is shaken, fetch an answer
      },
    );
  }

  // Method to change the audio effects state
  void changeAudioEffects() {
    emit(state.copyWith(isAudioEffectTurnedOn: !state.isAudioEffectTurnedOn));
  }

  // Method to update the selected text animation
  void selectedTextAnimation(String val) {
    emit(state.copyWith(selectedTextAnimation: val));
  }

  // Method to toggle text-to-speech feature
  void changeTextToSpeach() {
    emit(state.copyWith(isSttTurnedOn: !state.isSttTurnedOn));
  }

  // Method to change the bounce speed of the Magic Ball animation
  void changeBounceSpeed(
      AnimationController animationController, double speed) {
    animationController.duration = Duration(microseconds: speed.toInt());
    emit(state.copyWith(speedOfBouncing: speed));
  }

  // Method to get an answer from an API using DioRepository
  Future<String> getAnswer() async {
    DioRepository dioRepository = DioRepository();
    final response = await dioRepository.getFromApi();
    return response.data['reading'];
  }

  // Method to pick an audio file using FilePicker
  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      emit(state.copyWith(assetPath: result.files.first.path!));
    }
  }

  // Method to fetch an answer and handle audio and text-to-speech
  void fetchAnswer() async {
    if (!state.isLoading || state.errorHappened) {
      final player = AudioPlayer();
      try {
        emit(state.copyWith(isLoading: true));
        String answer = await getAnswer();

        emit(state.copyWith(errorHappened: false));

        // Use the selected audio asset or default audio for success
        state.assetPath != null
            ? await player.setFilePath(state.assetPath!)
            : await player.setAsset("assets/audio/success.mp3");

        FlutterTts ftts = FlutterTts();
        player.setVolume(0.35);
        if (state.isAudioEffectTurnedOn) {
          player.play(); // Play audio effect if audio effects are turned on
        }
        emit(state.copyWith(answerText: answer));

        if (state.isSttTurnedOn) {
          await ftts.speak(answer); // Use text-to-speech if enabled
        }

        // Delay to clear answer text and stop audio
        Future.delayed(Duration(milliseconds: 6000), () {
          emit(state.copyWith(isLoading: false, answerText: ''));

          player.stop();
        });
      } on DioException catch (e) {
        // Handle Dio exception, play error audio, and update state
        emit(state.copyWith(
            answerText: DioExceptions.fromDioError(e).toString(),
            errorHappened: true));

        await player.setAsset("assets/audio/error.mp3");
        player.play();
      }
    }
  }
}
