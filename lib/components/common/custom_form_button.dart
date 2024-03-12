import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  const CustomFormButton(
      {super.key, required this.innerText, required this.onPressed});

  final void Function()? onPressed;
  final String innerText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xff233743),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
