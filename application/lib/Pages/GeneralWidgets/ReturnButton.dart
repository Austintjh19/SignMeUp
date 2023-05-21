import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  final BuildContext context;

  const ReturnButton({
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
        width: 30,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('../lib/Images/Return_Icon.png'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
