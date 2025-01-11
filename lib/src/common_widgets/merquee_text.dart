import 'package:flutter/material.dart';

class MarqueeText extends StatefulWidget {
  final String text;
  final double width;
  final TextStyle style;

  const MarqueeText({super.key,
    required this.text,
    required this.width,
    this.style = const TextStyle(),
  });

  @override
  MarqueeTextState createState() => MarqueeTextState();
}

class MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animationController.addListener(() {
      _scrollController.jumpTo(
        _animationController.value * _scrollController.position.maxScrollExtent,
      );
    });

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Text(
          '  ${widget.text}  ',
          style: widget.style,
        ),
      ),
    );
  }
}
