import 'package:app_provider/app_provider.dart';
import 'package:components/animations/animate_do_zooms.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class CounterValue extends StatefulWidget {
  const CounterValue({Key? key}) : super(key: key);

  @override
  State<CounterValue> createState() => _CounterValueState();
}

class _CounterValueState extends State<CounterValue> {
  late AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    // _animationController.forward(from: 0.0);
    return ZoomIn(
      duration: const Duration(milliseconds: 400),
      manualTrigger: true,
      controller: (controller) => animationController = controller,
      child: Text(
        context
            .select(
                (CounterCubit counterCubit) => counterCubit.state.counterValue)
            .toString(),
        // context.watch()<CounterState>(context).counterValue.toString(),
        style: TxtStyle.b10.copyWith(
          color: const Color(0XFF8E8EA9),
        ),
      ),
    );
  }
}
