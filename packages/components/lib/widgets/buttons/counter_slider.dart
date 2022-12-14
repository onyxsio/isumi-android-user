import 'package:app_provider/app_provider.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'counter_value.dart';

class CounterSlider extends StatefulWidget {
  const CounterSlider({Key? key, required this.quantity}) : super(key: key);
  final String quantity;
  @override
  State<CounterSlider> createState() => _Stepper2State();
  // _Stepper2State createState() => _Stepper2State();
}

// SingleTickerProviderStateMixin
class _Stepper2State extends State<CounterSlider>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late double _startAnimationPosX;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    _animation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(1.5, 0.0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(1.5, 0.0))
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    // int value = Provider.of<CounterState>(context, listen: false).counterValue;
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        return FittedBox(
          child: SizedBox(
            width: 42.0.w,
            height: 8.0.h,
            child: Material(
              type: MaterialType.canvas,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(60.0),
              color: const Color(0XFFF6F6F9),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 10.0,
                    bottom: null,
                    child: Icon(
                      Icons.remove,
                      size: 10.0.w,
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.5),
                    ),
                  ),
                  Positioned(
                    right: 10.0,
                    top: null,
                    child: Icon(
                      Icons.add,
                      size: 10.0.w,
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.5),
                    ),
                  ),
                  GestureDetector(
                    onHorizontalDragStart: _onPanStart,
                    onHorizontalDragUpdate: _onPanUpdate,
                    onHorizontalDragEnd: (details) {
                      _onPanEnd(details, state.counterValue);
                    },
                    child: SlideTransition(
                      position: _animation,
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Material(
                          color: AppColor.white,
                          shape: const CircleBorder(),
                          elevation: 5.0,
                          child: const Center(
                            child: CounterValue(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;

    return ((local.dx * 0.75) / box.size.width) - 0.4;
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details, int value) {
    _controller.stop();

    if (_controller.value <= -0.20) {
      if (value > 1) {
        context.read<CounterCubit>().decrement();
      }
    } else if (_controller.value >= 0.20) {
      if (int.parse(widget.quantity) > value) {
        context.read<CounterCubit>().increment();
      }
    }

    final SpringDescription kDefaultSpring = SpringDescription.withDampingRatio(
      mass: 0.9,
      stiffness: 250.0,
      ratio: 0.6,
    );

    _controller.animateWith(
        SpringSimulation(kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
  }
}
