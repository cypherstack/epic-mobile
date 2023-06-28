import 'dart:async';

import 'package:flutter/cupertino.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    Key? key,
    required this.stringsToLoopThrough,
    required this.style,
    this.duration = const Duration(milliseconds: 700),
  }) : super(key: key);

  final List<String> stringsToLoopThrough;
  final TextStyle style;
  final Duration duration;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  Timer? _timer;
  late String _text;
  late final List<String> _strings;
  int _currentIndex = 0;
  final _key = GlobalKey();

  void update() {
    if (_currentIndex < _strings.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    setState(() {
      _text = _strings[_currentIndex];
    });
  }

  double? _width;

  @override
  void initState() {
    _strings = widget.stringsToLoopThrough;
    _text = _strings.last;
    _currentIndex = _strings.length - 1;

    _timer = Timer.periodic(widget.duration, (_) {
      update();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_width == null && _key.currentContext?.size?.width != null) {
        setState(() {
          _width = _key.currentContext?.size?.width;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Text(
        _text,
        key: _key,
        style: widget.style,
      ),
    );
  }
}
