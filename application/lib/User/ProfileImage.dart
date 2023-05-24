import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CircleAvatar(
      radius: width * 0.25,
      child: const SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Icon(
            Icons.person_2_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
