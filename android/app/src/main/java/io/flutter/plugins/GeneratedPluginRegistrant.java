package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.mtechviral.musicfinder.MusicFinderPlugin;
import com.example.medianotification.MediaNotificationPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    MusicFinderPlugin.registerWith(registry.registrarFor("com.mtechviral.musicfinder.MusicFinderPlugin"));
    MediaNotificationPlugin.registerWith(registry.registrarFor("com.example.medianotification.MediaNotificationPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
