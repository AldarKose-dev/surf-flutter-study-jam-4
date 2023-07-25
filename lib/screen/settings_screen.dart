import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surfpracticemagicball/presentation/cubit/magic_ball_cubit.dart';
import 'package:surfpracticemagicball/presentation/cubit/magic_ball_state.dart';

class SettingsPage extends StatefulWidget {
  final AnimationController animationController;

  const SettingsPage({super.key, required this.animationController});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationSwitch = false;
  bool _darkModeSwitch = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagicBallCubit, MagicBallState>(
      builder: (context, state) {
        List<DropdownMenuItem<String>> menuItems = List.generate(4, (index) {
          return DropdownMenuItem(
              value: state.availableAnimation[index],
              child: Row(
                children: [
                  Text(state.availableAnimation[index]),
                ],
              ));
        });
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: ListView(
            children: [
              SwitchListTile(
                title: Text('Speech to text'),
                value: state.isSttTurnedOn,
                onChanged: (value) {
                  context.read<MagicBallCubit>().changeTextToSpeach();
                },
              ),
              SwitchListTile(
                title: Text('Audio effects'),
                value: state.isAudioEffectTurnedOn,
                onChanged: (value) {
                  context.read<MagicBallCubit>().changeAudioEffects();
                },
              ),
              // SwitchListTile(
              //   title: Text('Dragon ball animation speed'),
              //   value: _darkModeSwitch,
              //   onChanged: (value) {
              //     setState(() {
              //       _darkModeSwitch = value;
              //     });
              //   },
              // ),
              // Slider(
              //     value: state.speedOfBouncing.toDouble(),
              //     min: 100,
              //     max: 1500,
              //     onChanged: (newVal) => context
              //         .read<MagicBallCubit>()
              //         .changeBounceSpeed(widget.animationController, newVal))
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Music asset path"),
                    Flexible(
                      child: TextButton(
                          onPressed: () =>
                              context.read<MagicBallCubit>().pickAudioFile(),
                          child: Text(state.assetPath == null
                              ? "Choose your audio file"
                              : state.assetPath!)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Music asset path"),
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
              )
            ],
          ),
        );
      },
    );
  }
}
