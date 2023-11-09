import 'dart:async';
import 'package:flutter/material.dart';

class CustomSlidetransition extends StatefulWidget {
  final Widget child;
  final double dx, dy;
  final int duration;
  final Function()? isCompleted;
  CustomSlidetransition(
      {required this.child,
      this.dx = 2,
      this.dy = 0,
      this.duration = 400,
      this.isCompleted});
  @override
  _CustomSlidetransitionState createState() => _CustomSlidetransitionState();
}

class _CustomSlidetransitionState extends State<CustomSlidetransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    Timer(Duration(milliseconds: 200), () {
      try {
        _animationController.forward();
      } catch (error) {}
    });

    _animationController.addListener(() {
      try {
        if (_animationController.isCompleted) {
          if (widget.isCompleted != null) widget.isCompleted!();
        }
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    try {
      _animationController.dispose();
    } catch (error) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position:
            Tween<Offset>(begin: Offset(widget.dx, widget.dy), end: Offset.zero)
                .animate(_animationController),
        child: widget.child);
  }
}
