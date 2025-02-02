import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/category_selection_screen.dart';
import 'services/wallpaper_service.dart'; // Import services
import 'services/quote_service.dart';
import 'services/wallpaper_setter_service.dart';
import 'services/schedule_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // Instantiate services
  final wallpaperService = WallpaperService();
  final quoteService = QuoteService();
  final wallpaperSetterService = WallpaperSetterService();
  final scheduleService = ScheduleService( // Instantiate ScheduleService with dependencies
    prefs: prefs,
    wallpaperService: wallpaperService,
    quoteService: quoteService,
    wallpaperSetterService: wallpaperSetterService,
  );

  runApp(MyApp(
    prefs: prefs,
    wallpaperService: wallpaperService, // Pass services to MyApp
    quoteService: quoteService,
    wallpaperSetterService: wallpaperSetterService,
    scheduleService: scheduleService,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final WallpaperService wallpaperService; // Receive services
  final QuoteService quoteService;
  final WallpaperSetterService wallpaperSetterService;
  final ScheduleService scheduleService;

  const MyApp({
    super.key,
    required this.prefs,
    required this.wallpaperService,
    required this.quoteService,
    required this.wallpaperSetterService,
    required this.scheduleService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motiv8Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategorySelectionScreen( // Pass services to CategorySelectionScreen
        wallpaperService: wallpaperService,
        quoteService: quoteService,
        wallpaperSetterService: wallpaperSetterService,
        scheduleService: scheduleService,
      ),
    );
  }
}