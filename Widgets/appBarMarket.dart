import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/mainScreens/initialScreen.dart';

AppBar appBarMarket(BuildContext context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xfffce3ee),
    title: Text(
      "المتاجر",
      style: GoogleFonts.almarai(color: Colors.black),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.search,
        color: Colors.black,
      ),
      onPressed: () {
        // _showSearchDialog();
      },
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => InitialScreen()));
        },
      ),
    ],
  );
}
