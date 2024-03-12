import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageHeading extends StatelessWidget {
  const PageHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
      child: Text(
        title,
        style:GoogleFonts.odibeeSans(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
