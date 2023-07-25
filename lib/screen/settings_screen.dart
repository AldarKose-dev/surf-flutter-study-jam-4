import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surfpracticemagicball/presentation/cubit/magic_ball_cubit.dart';
import 'package:surfpracticemagicball/presentation/cubit/magic_ball_state.dart';

class SettingsPage extends StatefulWidget {
  final AnimationController animationController;

  const SettingsPage({Key? key, required this.animationController})
      : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagicBallCubit, MagicBallState>(
      builder: (context, state) {
        // Create a list of DropdownMenuItem based on available animations
        List<DropdownMenuItem<String>> menuItems = List.generate(4, (index) {
          return DropdownMenuItem(
            value: state.availableAnimation[index],
            child: Row(
              children: [
                Text(state.availableAnimation[index]),
              ],
            ),
          );
        });

        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: ListView(
            children: [
              // Switch for enabling/disabling text-to-speech
              SwitchListTile(
                title: const Text('Speech to text'),
                value: state.isSttTurnedOn,
                onChanged: (value) {
                  context.read<MagicBallCubit>().changeTextToSpeach();
                },
              ),
              // Switch for enabling/disabling audio effects
              SwitchListTile(
                title: const Text('Audio effects'),
                value: state.isAudioEffectTurnedOn,
                onChanged: (value) {
                  context.read<MagicBallCubit>().changeAudioEffects();
                },
              ),
              // Slider for adjusting the speed of the ball animation
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Speed of ball animation"),
                    Slider(
                      value: state.speedOfBouncing.toDouble(),
                      min: 1,
                      max: 10,
                      onChanged: (newVal) {
                        context.read<MagicBallCubit>().changeBounceSpeed(
                            widget.animationController, newVal);
                      },
                    ),
                  ],
                ),
              ),
              // TextButton for picking an audio file for the background music
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Music asset path"),
                    Flexible(
                      child: TextButton(
                        onPressed: () =>
                            context.read<MagicBallCubit>().pickAudioFile(),
                        child: Text(state.assetPath == null
                            ? "Choose your audio file"
                            : state.assetPath!),
                      ),
                    ),
                  ],
                ),
              ),
              // DropdownButton for selecting text animation effect
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Text animation effect"),
                    DropdownButton(
                      borderRadius: BorderRadius.circular(12.r),
                      style: Theme.of(context).textTheme.titleSmall,
                      items: menuItems,
                      value: state.selectedTextAnimation,
                      alignment: AlignmentDirectional.centerEnd,
                      onChanged: (String? newValue) {
                        context
                            .read<MagicBallCubit>()
                            .selectedTextAnimation(newValue!);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
