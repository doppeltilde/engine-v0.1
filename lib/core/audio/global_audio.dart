import 'package:flutter/material.dart';
import 'package:salem/core/audio/ambience_audio.dart';
import 'package:salem/core/audio/game_audio.dart';
import 'package:salem/core/audio/voice_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class GlobalAudio {
  final String? musicName;
  GlobalAudio({this.musicName});
  static final playAudio = PlayAudio();
}

class PlayAudio with WidgetsBindingObserver {
  SharedPreferences? sharedPreferences;
  bool isPlaying = false;

  Future<void> getBGM(String musicName) async {
    isPlaying = true;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      if (musicName.isNotEmpty) {
        // GameAudioDesktop.playBGMDesktop.play(musicName);
      } else {}
    } else {
      if (musicName.isNotEmpty) {
        GameAudio.playBGM.play(musicName);
      } else {}
    }
  }

  Future<void> getVoice(String musicName) async {
    isPlaying = true;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      // if (VoiceAudioDesktop.playVoiceDesktop.isPlaying == false) {
      //   VoiceAudioDesktop.playVoiceDesktop.play(musicName);
      // } else {
      //   VoiceAudioDesktop.playVoiceDesktop.stop();
      //   VoiceAudioDesktop.playVoiceDesktop.play(musicName);
      // }
    } else {
      if (VoiceAudio.playVoice.isPlaying == false) {
        VoiceAudio.playVoice.play(musicName);
      } else {
        VoiceAudio.playVoice.stop();
        VoiceAudio.playVoice.play(musicName);
      }
    }
  }

  Future<void> getAmbience(String musicName) async {
    isPlaying = true;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      // if (AmbienceAudioDesktop.playBGMDesktop.isPlaying == false) {
      //   AmbienceAudioDesktop.playBGMDesktop.play(musicName);
      // } else {
      //   AmbienceAudioDesktop.playBGMDesktop.stop();
      //   AmbienceAudioDesktop.playBGMDesktop.play(musicName);
      // }
    } else {
      if (AmbienceAudio.playAmbience.isPlaying == false) {
        AmbienceAudio.playAmbience.play(musicName);
      } else {
        AmbienceAudio.playAmbience.stop();
        AmbienceAudio.playAmbience.play(musicName);
      }
    }
  }

  Future<void> stopAudio() async {
    //isPlaying = false;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      // GameAudioDesktop.playBGMDesktop.stop();
    } else {
      GameAudio.playBGM.stop();
    }
  }

  Future<void> stopAmbienceAudio() async {
    //isPlaying = false;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      // AmbienceAudioDesktop.playBGMDesktop.stop();
    } else {
      AmbienceAudio.playAmbience.stop();
    }
  }

  Future<void> stopVoiceAudio() async {
    //isPlaying = false;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      // VoiceAudioDesktop.playVoiceDesktop.stop();
    } else {
      VoiceAudio.playVoice.stop();
    }
  }

  // @override
  // void didChangeDependencies() {
  //   if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
  //     super.didChangeDependencies();
  //     GameAudioDesktop.playAudio.player = Player(
  //       id: 0,
  //     );
  //   }
  // }
}
