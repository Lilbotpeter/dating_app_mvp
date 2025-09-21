//พรุ่งนี้มานั่งทำความเข้าใจ logic ด้วย
import 'dart:async';

import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final String? message;
  final Color barrierColor;
  final Widget indicator;

  const LoadingOverlay({
    super.key,
    this.message,
    this.barrierColor = const Color(0x99000000),
    this.indicator = const CircularProgressIndicator(),
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: IgnorePointer(
      child: ColoredBox(
        color: barrierColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              indicator,
              if (message != null) ...[
                const SizedBox(
                  height: 12,
                ),
                Text(
                  message!,
                  style: const TextStyle(color: Colors.white),
                )
              ]
            ],
          ),
        ),
      ),
    ));
  }
}

class LoadingOverlayWrapper extends StatefulWidget {
  final Widget child;
  final bool show;
  final String? message;
  final Duration delay;
  final Duration minimumShowTime;
  const LoadingOverlayWrapper({
    super.key,
    required this.child,
    required this.show,
    this.message,
    this.delay = const Duration(milliseconds: 150),
    this.minimumShowTime = const Duration(milliseconds: 250),
  });

  @override
  State<LoadingOverlayWrapper> createState() => _LoadingOverlayWrapperState();
}

class _LoadingOverlayWrapperState extends State<LoadingOverlayWrapper> {
  bool _visible = false;
  Timer? _delayTimer;
  Timer? _hideTimer;
  DateTime? _visibleSince;

  @override
  void initState() {
    super.initState();
    if (widget.show) _scheduleShow();
  }

  @override
  void didUpdateWidget(covariant LoadingOverlayWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !_visible) {
      _scheduleShow();
    } else if (!widget.show && (_visible || _delayTimer != null)) {
      _scheduleHide();
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _scheduleShow() {
    _hideTimer?.cancel();
    _delayTimer?.cancel();

    if (_visible) {
      _visibleSince ??= DateTime.now();
      return;
    }

    _delayTimer = Timer(widget.delay, () {
      if (!mounted || !widget.show) return;
      setState(() {
        _visible = true;
        _visibleSince = DateTime.now();
      });
    });
  }

  void _scheduleHide() {
    _delayTimer?.cancel();

    if (!_visible) {
      _visibleSince = null;
      return;
    }

    final since = _visibleSince ?? DateTime.now();
    final elapsed = DateTime.now().difference(since);
    final remaining = widget.minimumShowTime - elapsed;

    if (remaining > Duration.zero) {
      _hideTimer?.cancel();
      _hideTimer = Timer(remaining, () {
        if (!mounted || widget.show) return;
        setState(() {
          _visible = false;
          _visibleSince = null;
        });
      });
    } else {
      _hideTimer?.cancel();
      if (!mounted) return;
      setState(() {
        _visible = false;
        _visibleSince = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_visible) LoadingOverlay(message: widget.message),
      ],
    );
  }
}
