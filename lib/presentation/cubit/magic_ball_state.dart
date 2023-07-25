import 'package:freezed_annotation/freezed_annotation.dart';

part 'magic_ball_state.freezed.dart';

@Freezed()
class MagicBallState with _$MagicBallState {
  const factory MagicBallState(
      {@Default(true) bool isAudioEffectTurnedOn,
      @Default(true) bool isSttTurnedOn,
      @Default(1) double speedOfBouncing,
      @Default("") String answerText,
      @Default(false) bool isLoading,
      String? assetPath,
      @Default(["Fade", "Typer", "Typewriter", "Scale"])
      List<String> availableAnimation,
      @Default("Fade") String selectedTextAnimation,
      @Default(false) bool errorHappened}) = _MagicBallState;
}
