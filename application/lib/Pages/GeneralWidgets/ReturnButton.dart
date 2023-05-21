import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  final BuildContext context;

  const ReturnButton({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton.icon(
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    //   icon: Image.asset(
    //     '../lib/Images/Return_Icon.png',
    //     height: 30,
    //     width: 30,
    //     opacity: const AlwaysStoppedAnimation(0.8),
    //   ),
    //   label: const Text(''),
    //   style: ElevatedButton.styleFrom(
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //   ),
    // );

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
