import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The looping background music class.
///
/// This class helps with looping background music management that reacts to
/// application lifecycle state changes. On construction, the instance is added
/// as an observer to the [WidgetsBinding] instance. A [dispose] function is
/// provided in case this functionality needs to be unloaded but the app needs
/// to keep running.
class Bgm extends WidgetsBindingObserver {
  bool _isRegistered = false;
  late AudioCache audioCache;
  AudioPlayer? audioPlayer;
  bool isPlaying = false;

  Bgm({AudioCache? audioCache}) : audioCache = audioCache ?? AudioCache();

  /// Registers a [WidgetsBinding] observer.
  ///
  /// This must be called for auto-pause and resume to work properly.
  void initialize() {
    if (_isRegistered) {
      return;
    }
    _isRegistered = true;
    WidgetsBinding.instance?.addObserver(this);
  }

  /// Dispose the [WidgetsBinding] observer.
  void dispose() {
    if (!_isRegistered) {
      return;
    }
    WidgetsBinding.instance?.removeObserver(this);
    _isRegistered = false;
  }

  /// Plays and loops a background music file specified by [filename].
  ///
  /// The volume can be specified in the optional named parameter [volume]
  /// where `0` means off and `1` means max.
  ///
  /// It is safe to call this function even when a current BGM track is
  /// playing.
  ///
  Future<void> play(String filename, {double volume = 1.0}) async {
    //AudioService service = Provider.of<AudioService>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('musicVolumeValue');
    final currentPlayer = audioPlayer;
    if (currentPlayer != null && currentPlayer.state != PlayerState.STOPPED) {
      currentPlayer.stop();
    }

    isPlaying = true;
    audioPlayer = await audioCache.loop(filename, volume: vol ?? 1.0);
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    if (audioPlayer != null) {
      await audioPlayer!.stop();
    }
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    if (audioPlayer != null) {
      isPlaying = true;
      await audioPlayer!.resume();
    }
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    if (audioPlayer != null) {
      isPlaying = false;
      await audioPlayer!.pause();
    }
  }

  Future<void> volume(volume) async {
    await audioPlayer!.setVolume(volume);
  }

  /// Pre-fetch an audio and store it in the cache.
  ///
  /// Alias of `audioCache.load();`.
  Future<Uri> load(String file) => audioCache.load(file);

  /// Pre-fetch an audio and store it in the cache.
  ///
  /// Alias of `audioCache.loadAsFile();`.
  Future<File> loadAsFile(String file) => audioCache.loadAsFile(file);

  /// Pre-fetch a list of audios and store them in the cache.
  ///
  /// Alias of `audioCache.loadAll();`.
  Future<List<Uri>> loadAll(List<String> files) => audioCache.loadAll(files);

  /// Clears the file in the cache.
  ///
  /// Alias of `audioCache.clear();`.
  void clear(Uri file) => audioCache.clear(file);

  /// Clears all the audios in the cache.
  ///
  /// Alias of `audioCache.clearAll();`.
  void clearAll() => audioCache.clearAll();

  /// Handler for AppLifecycleState changes.
  ///
  /// This function handles the automatic pause and resume when the app
  /// lifecycle state changes. There is NO NEED to call this function directly
  /// directly.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying && audioPlayer?.state == PlayerState.PAUSED) {
        audioPlayer?.resume();
      }
    } else {
      audioPlayer?.pause();
    }
  }
}

class PlayDesktopAudio extends WidgetsBindingObserver {
  Player? player;
  bool isPlaying = false;

  /// Plays and loops a background music file specified by [filename].
  ///
  /// The volume can be specified in the optional named parameter [volume]
  /// where `0` means off and `1` means max.
  ///
  /// It is safe to call this function even when a current BGM track is
  /// playing.
  ///
  /// For macOS use 'gameAudio.bgm'.
  Future<void> play(String filename, {double volume = 1.0}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('musicVolumeValue');
    await player?.open(
      Playlist(
        playlistMode: PlaylistMode.loop,
        medias: [
          await Media.asset('assets/audio/' + filename),
        ],
      ),
    );
    await player?.setVolume(vol ?? 1.0);
    isPlaying = true;
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    if (player != null) {
      await player?.stop();
    }
  }

  /// Pauses the currently playing background music track.
  Future<void> pause() async {
    if (player != null) {
      isPlaying = false;
      await player?.pause();
    }
  }

  /// Sets the volume of the current audio instance.
  Future<void> volume(volume) async {
    await player?.setVolume(volume);
  }
}
