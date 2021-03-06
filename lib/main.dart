import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_countup/data/count_data.dart';
import 'package:riverpod_countup/logic/button_animation_logic.dart';
import 'package:riverpod_countup/provider.dart';
import 'package:riverpod_countup/view_model.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(ViewModel()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final ViewModel viewModel;
  MyHomePage(
    this.viewModel, {
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  // MyHomePage({Key? key}) : super(key: key);

  late ViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = widget.viewModel;
    _viewModel.setRef(ref, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(titleProvider)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(descriptionProvider),
            ),
            Text(
              _viewModel.count,
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: _viewModel.onIncrease,
                  child: ButtonAnimation(
                    animationCombination: _viewModel.animationPlusCombination,
                    child: const Icon(CupertinoIcons.plus),
                  ),
                ),
                FloatingActionButton(
                  onPressed: _viewModel.onDecrease,
                  child: ButtonAnimation(
                    animationCombination: _viewModel.animationMinusCombination,
                    child: const Icon(CupertinoIcons.minus),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_viewModel.countUp),
                Text(_viewModel.countDown),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.onReset,
        child: ButtonAnimation(
          animationCombination: _viewModel.animationResetCombination,
          child: const Icon(CupertinoIcons.refresh),
        ),
      ),
    );
  }
}

class ButtonAnimation extends StatelessWidget {
  final AnimationCombination animationCombination;
  final Widget child;

  const ButtonAnimation(
      {Key? key, required this.animationCombination, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: RotationTransition(
        turns: animationCombination.animationRotation,
        child: child,
      ),
      scale: animationCombination.animationScale,
    );
  }
}
