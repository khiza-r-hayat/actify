import 'package:flutter/material.dart';

class DefaultUserImageWidget extends StatelessWidget {
  const DefaultUserImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/user.png',
              ))),
    );
  }
}
