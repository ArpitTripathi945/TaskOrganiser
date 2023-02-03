import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
