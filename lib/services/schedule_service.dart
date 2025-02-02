// ignore_for_file: avoid_print

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/wallpaper_service.dart';
import '../services/quote_service.dart';
import '../services/wallpaper_setter_service.dart';

class ScheduleService {
  static const String _timeframeKey = 'timeframe_minutes';
  static const String _lastChangeKey = 'last_wallpaper_change';
  Timer? _timer;
  final SharedPreferences _prefs; // Inject SharedPreferences
  final WallpaperService _wallpaperService; // Inject WallpaperService
  final QuoteService _quoteService;       // Inject QuoteService
  final WallpaperSetterService _wallpaperSetterService; // Inject WallpaperSetterService

  ScheduleService({
    required SharedPreferences prefs,
    required WallpaperService wallpaperService,
    required QuoteService quoteService,
    required WallpaperSetterService wallpaperSetterService,
  })  : _prefs = prefs,
        _wallpaperService = wallpaperService,
        _quoteService = quoteService,
        _wallpaperSetterService = wallpaperSetterService;


  Future<void> setTimeframe(int timeframeMinutes) async {
    await _prefs.setInt(_timeframeKey, timeframeMinutes);
    startScheduling();
  }

  int getTimeframe() { // Removed async/Future, as SharedPreferences is already initialized in constructor.
    return _prefs.getInt(_timeframeKey) ?? 0;
  }

  void startScheduling() { // Removed async/Future, as it's not doing asynchronous operations directly here.
    stopScheduling(); // Stop any existing timer

    final timeframeMinutes = getTimeframe();
    if (timeframeMinutes <= 0) {
      print("No valid timeframe set for scheduling.");
      return;
    }

    _timer = Timer.periodic(Duration(minutes: timeframeMinutes), (_) {
      _scheduleWallpaperChange();
    });
    print('Wallpaper scheduling started for every $timeframeMinutes minutes.'); // Added print for confirmation
  }

  void stopScheduling() {
    _timer?.cancel();
    _timer = null;
    print('Wallpaper scheduling stopped.'); // Added print for confirmation
  }

  Future<void> _scheduleWallpaperChange() async {
    try {
      DateTime? lastChange = _getLastWallpaperChangeTime(); // Get DateTime from prefs
      final timeframeMinutes = getTimeframe();
      DateTime currentTime = DateTime.now();

      if (lastChange == null || currentTime.difference(lastChange) >= Duration(minutes: timeframeMinutes)) {
        print("Time to change wallpaper!");

        final wallpaper = await _wallpaperService.getRandomWallpaper();
        final quote = await _quoteService.getRandomQuote();

        if (wallpaper != null && quote != null) { // Null checks for fetched data.
          print("Fetched wallpaper: ${wallpaper.imageUrl}");
          print("Fetched quote: ${quote.text}");

          await _wallpaperSetterService.setWallpaperFromUrl(wallpaper.imageUrl);
          _setLastWallpaperChangeTime(currentTime); // Store DateTime in prefs
          print("Wallpaper changed successfully.");
        } else {
          print("Failed to fetch new wallpaper or quote."); // Handle case where fetching fails.
        }

      } else {
        print("Not yet time to change wallpaper. Last change was at: $lastChange"); // Print last change time for clarity
      }
    } catch (e) {
      print("Error during wallpaper scheduling: $e");
    }
  }


  void _setLastWallpaperChangeTime(DateTime time) {
    _prefs.setString(_lastChangeKey, time.toIso8601String());
  }

  DateTime? _getLastWallpaperChangeTime() {
    String? timeString = _prefs.getString(_lastChangeKey);
    if (timeString != null) {
      return DateTime.tryParse(timeString);
    }
    return null;
  }
}