import 'package:flutter/material.dart';

class AnimatedStatItem extends StatelessWidget {
  final String label;
  final String value;
  final int delay;

  const AnimatedStatItem({
    Key? key,
    required this.label,
    required this.value,
    required this.delay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: delay + 700),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: scale.clamp(0.0, 1.0),
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
