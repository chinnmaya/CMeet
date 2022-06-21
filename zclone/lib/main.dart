import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zclone/screens/meeting_screen.dart';
import '/resources/auth_methods.dart';
import '/screens/home_screen.dart';
import '/screens/sign_in.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import '/screens/video_call_screen.dart';
import '/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => signin(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(),
      },
      home: AnimatedSplashScreen(
        duration: 3000,
        backgroundColor: Color.fromARGB(1, 6, 45, 197),
        splashTransition: SplashTransition.sizeTransition,
        splash: Image.asset("assets/images/ic_launcher.png"),
        splashIconSize: double.maxFinite,
        centered: true,
        nextScreen: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return HomeScreen();
            }

            return signin();
          },
        ),
      ),
    );
  }
}
