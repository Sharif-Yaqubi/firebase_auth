import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.4,
      child: Lottie.asset('assets/signUp.json'),
    );
  }
}
