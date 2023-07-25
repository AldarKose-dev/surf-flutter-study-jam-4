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
    detector = ShakeDetector.autoStart(
      shakeThresholdGravity: 1.5,
      minimumShakeCount: 1,
      onPhoneShake: () {
        fetchAnswer();
      },
    );
  }
  void changeAudioEffects() {
    emit(state.copyWith(isAudioEffectTurnedOn: !state.isAudioEffectTurnedOn));
  }

  void selectedTextAnimation(String val) {
    emit(state.copyWith(selectedTextAnimation: val));
  }

  void changeTextToSpeach() {
    emit(state.copyWith(isSttTurnedOn: !state.isSttTurnedOn));
  }

  void changeBounceSpeed(
      AnimationController animationController, double speed) {
    animationController.duration = Duration(microseconds: speed.toInt());
    emit(state.copyWith(speedOfBouncing: speed));
  }

  Future<String> getAnswer() async {
    DioRepository dioRepository = DioRepository();
    final response = await dioRepository.getFromApi();
    return response.data['reading'];
  }

  Future<void> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      emit(state.copyWith(assetPath: result.files.first.path!));
    }
  }
  
  void fetchAnswer() async {
    if (!state.isLoading || state.errorHappened) {
      final player = AudioPlayer();
      print(state.isLoading);
      print(state.errorHappened);
      try {
        emit(state.copyWith(isLoading: true));
        String answer = await getAnswer();

        emit(state.copyWith(errorHappened: false));

        // final player = AudioPlayer();
        state.assetPath != null
            ? await player.setFilePath(state.assetPath!)
            : await player.setAsset("assets/audio/success.mp3");

        FlutterTts ftts = FlutterTts();
        player.setVolume(0.35);
        if (state.isAudioEffectTurnedOn) {
          player.play(); // Play without waiting for completion
        }
        emit(state.copyWith(answerText: answer));
        if (state.isSttTurnedOn) {
          await ftts.speak(answer);
        }

        Future.delayed(Duration(milliseconds: 6000), () {
          emit(state.copyWith(isLoading: false, answerText: ''));

          player.stop(); // Play without waiting for completion
        });
      } on DioException catch (e) {
        // print(e);
        emit(state.copyWith(
            // isLoading: false,
            answerText: DioExceptions.fromDioError(e).toString(),
            errorHappened: true));

        await player.setAsset("assets/audio/error.mp3");
        player.play();
      }
    }
  }
}
