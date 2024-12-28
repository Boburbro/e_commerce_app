import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({required this.child, required this.number, super.key});

  final Widget child;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        child,
        Positioned(
          top: 15,
          right: 10,
          child: Container(
            alignment: Alignment.center,
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(fontSize: 8),
            ),
          ),
        )
      ],
    );
  }
}
