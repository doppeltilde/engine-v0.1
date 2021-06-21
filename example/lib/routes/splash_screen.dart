import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/core/persist/splash.dart';
import 'dart:io' show Platform;
import 'package:salem/core/audio/gameAudio.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Starting opacity.
  double opacity = 0.0;

  /// Duration the splash screen is alive.
  int splashScreenDuration = 3;

  /// the opacity duration.
  int opacityDuration = 1;

  /// Main Menu route defined in Route
  String mainmenu = "/mainmenu";

  @override
  Widget build(BuildContext context) {
    return SplashLoadingScreen(
      bgColor: Colors.black,
      opacity: opacity,
      imgDuration: 250,
      splashImage: "assets/images/MUTA.png",
    );
  }

  /// PRECACHE IMAGES
  /// List of all images which should be pre-cached.
  List<Map<String, dynamic>> images = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Platform.isWindows ||
        Platform.isLinux &&
            GameAudioDesktop.playDesktopAudio.isPlaying == false) {
      super.didChangeDependencies();
      GameAudioDesktop.playDesktopAudio.player = Player(
        id: 0,
      );
    }
    for (var i in images) {
      precacheImage(AssetImage(i["image"]), context);
    }
  }
  // PRECACHE IMAGES

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: splashScreenDuration), () {
      PersistNavigation.initSplash(context, mainmenu);
    });
    Future.delayed(Duration(seconds: opacityDuration), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
}
