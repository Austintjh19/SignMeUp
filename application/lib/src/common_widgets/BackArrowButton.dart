import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  final BuildContext context;

  const BackArrowButton({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 30,
        padding: const EdgeInsets.all(0),
        child: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
    );
  }
}
