import 'package:flutter/material.dart';

class FloatingBackButton extends StatelessWidget {
  const FloatingBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF231f20)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
