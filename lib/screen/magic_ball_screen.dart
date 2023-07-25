
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:surfpracticemagicball/presentation/cubit/magic_ball_cubit.dart';
import 'package:surfpracticemagicball/presentation/cubit/magic_ball_state.dart';
import 'package:surfpracticemagicball/screen/settings_screen.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _lightController;
  late Animation<double> _lightAnimation;
  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  void initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _lightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _lightAnimation = Tween<double>(begin: 0.1, end: 0.6).animate(
      CurvedAnimation(
        parent: _lightController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MagicBallCubit(),
      child: BlocBuilder<MagicBallCubit, MagicBallState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<MagicBallCubit>(),
                        child: SettingsPage(
                          animationController: _animationController,
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Icon(Icons.settings),
            ),
            body: NotificationListener(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Color.fromRGBO(212, 212, 255, 1),
                        ],
                        stops: [0.0, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        if (!state.isLoading || state.errorHappened) {
                          context.read<MagicBallCubit>().fetchAnswer();
                        }
                      },
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                0,
                                10 *
                                    _animationController.value *
                                    state.speedOfBouncing),
                            child: child!,
                          );
                        },
                        child: const Stack(
                          children: [
                            Image(
                              image: AssetImage("assets/circle.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state.isLoading)
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(275),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Stack(
                              children: [
                                Center(
                                  child: AnimatedBuilder(
                                    animation: _lightAnimation,
                                    builder: (context, child) {
                                      return Container(
                                        width: 275,
                                        height: 275,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: state.errorHappened
                                                  ? Colors.red.withOpacity(
                                                      _lightAnimation.value)
                                                  : Colors.white.withOpacity(
                                                      _lightAnimation.value),
                                              spreadRadius: 5,
                                              blurRadius: 30,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Center(
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: "Gill Sans",
                                      fontSize: 25,
                                      color: state.answerText.isNotEmpty
                                          ? const Color(0xff6C698C)
                                          : null,
                                    ),
                                    textAlign: TextAlign.center,
                                    child: AnimatedTextKit(
                                      repeatForever: state.errorHappened &&
                                          state.isLoading,
                                      animatedTexts: [
                                        state.selectedTextAnimation == "Fade"
                                            ? FadeAnimatedText(state.answerText)
                                            : state.selectedTextAnimation ==
                                                    "Typer"
                                                ? TyperAnimatedText(
                                                    state.answerText)
                                                : state.selectedTextAnimation ==
                                                        "Typewriter"
                                                    ? TypewriterAnimatedText(
                                                        state.answerText)
                                                    : state.selectedTextAnimation ==
                                                            "Scale"
                                                        ? ScaleAnimatedText(
                                                            state.answerText)
                                                        : FadeAnimatedText(
                                                            state.answerText)
                                      ],
                                      onTap: () {
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        kIsWeb
                            ? "Нажмите на шар "
                            : "Нажмите на шар или потрясите телефон",
                        style: TextStyle(
                          fontFamily: "Gill Sans",
                          fontSize: 16,
                          color: Color.fromRGBO(108, 110, 140, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
