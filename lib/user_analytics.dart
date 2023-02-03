import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAnalytics extends StatelessWidget {
  const UserAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Text(
        "Coming soon",
        style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.openSans().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    ));
  }
}
