//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audioplayers
import dart_vlc
import path_provider_macos
import salem
import shared_preferences_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioplayersPlugin.register(with: registry.registrar(forPlugin: "AudioplayersPlugin"))
  DartVlcPlugin.register(with: registry.registrar(forPlugin: "DartVlcPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SalemPlugin.register(with: registry.registrar(forPlugin: "SalemPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
}
