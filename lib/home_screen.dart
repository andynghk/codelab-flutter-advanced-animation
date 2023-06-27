import 'dart:async';

import 'package:flutter/material.dart';

const _speedOfLight = 299792458;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _speed = 0;

  /// 3
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );
  late final Animation _animation = IntTween(
    begin: 0,
    end: _speedOfLight,
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();

    /// 1. Beginner using setState
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        setState(() {
          _speed += 10;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final rocketTween = IntTween(begin: 0, end: _speedOfLight);

    final tween = IntTween(begin: 100, end: 200);
    final colorTween = ColorTween(begin: Colors.red, end: Colors.black);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '🚀',
              style: theme.textTheme.headlineLarge?.copyWith(fontSize: 70),
              textAlign: TextAlign.center,
            ),
            Text(
              '$_speed',
              style: theme.textTheme.headlineLarge?.copyWith(fontSize: 70),
              textAlign: TextAlign.center,
            ),
            const Text(
              'm/s',
              textAlign: TextAlign.center,
            ),

            /// 2. Advanced - using Tween
            TweenAnimationBuilder(
              tween: rocketTween,
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: theme.textTheme.headlineLarge?.copyWith(fontSize: 70),
                  textAlign: TextAlign.center,
                );
              },
            ),

            /// 3. More Advanced - using Single Ticker (Update per frame)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Text(
                  '${_animation.value}',
                  style: theme.textTheme.headlineLarge?.copyWith(fontSize: 70),
                  textAlign: TextAlign.center,
                );
              },
            ),
            TextButton(
              onPressed: () {
                _animationController.forward();
              },
              child: const Text('Accelerate'),
            ),
            TextButton(
              onPressed: () {
                _animationController.reverse();
              },
              child: const Text('Decelerate'),
            ),

            // const MultipleTricker(),

            /// Tween Example
            const SizedBox(height: 200),
            Text(
              tween.lerp(0.3).toString(),
              style: theme.textTheme.headlineMedium,
            ),
            Container(
              width: 100,
              height: 100,
              color: colorTween.lerp(0.95),
            )
          ],
        ),
      ),
    );
  }
}

class MultipleTricker extends StatefulWidget {
  const MultipleTricker({super.key});

  @override
  State<MultipleTricker> createState() => _MultipleTrickerState();
}

class _MultipleTrickerState extends State<MultipleTricker>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );
  late final Animation _animation = IntTween(
    begin: 0,
    end: _speedOfLight,
  ).animate(_animationController);

  late final AnimationController _colorAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  late final Animation _colorAnimation = ColorTween(
    begin: Colors.green,
    end: Colors.orange,
  ).animate(CurvedAnimation(
    parent: _colorAnimationController,
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  ));

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /// 4. More Advanced - using Ticker (Update per frame)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return AnimatedBuilder(
                  animation: _colorAnimation,
                  builder: (context, _) {
                    return Text(
                      '${_animation.value}',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 70,
                        color: _colorAnimation.value,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                );
              },
            ),
            TextButton(
              onPressed: () {
                _animationController.forward();
              },
              child: const Text('Accelerate'),
            ),
            TextButton(
              onPressed: () {
                _animationController.reverse();
              },
              child: const Text('Decelerate'),
            ),
          ],
        ),
      ),
    );
  }
}
