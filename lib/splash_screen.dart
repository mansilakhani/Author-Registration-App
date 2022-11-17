import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcca3f),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cover.png',
              scale: 7.8,
              //color: Color(0xff95618C4).withOpacity(0.8),
            ),
            Text(
              "Author Registration",
              style:
                  GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              color: Colors.black.withOpacity(0.65),
            )
          ],
        ),
      ),
    );
  }
}
