import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movei_app/bottom.dart';
import 'package:movei_app/state/notifier.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => saved(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(colorScheme: ColorScheme.dark(
          background: Colors.black
          
        )),
      
        home:SplashScreen(),
      ),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 7));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>page()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedFlickFlow(),
      ),
    );
  }
}

class AnimatedFlickFlow extends StatefulWidget {
  @override
  _AnimatedFlickFlowState createState() => _AnimatedFlickFlowState();
}

class _AnimatedFlickFlowState extends State<AnimatedFlickFlow> {
  String flickFlowText = 'FlickFlow';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  _animateText() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        currentIndex++;
      });

      if (currentIndex < flickFlowText.length) {
        _animateText();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      flickFlowText.substring(0, currentIndex),
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

