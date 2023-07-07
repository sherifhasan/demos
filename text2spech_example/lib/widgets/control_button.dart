import 'package:flutter/material.dart';

class BuildControlButton extends StatelessWidget {
  final Color color;
  final Color splashColor;
  final IconData icon;
  final String label;
  final Function func;

  const BuildControlButton({
    required this.color,
    required this.icon,
    required this.splashColor,
    required this.label,
    super.key,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          splashColor: splashColor,
          onPressed: () => func(),
        ),
        Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            ))
      ],
    );
  }
}
