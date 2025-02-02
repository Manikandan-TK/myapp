// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/timeframe_dropdown.dart';
import '../widgets/primary_button.dart';
import '../widgets/wallpaper_preview.dart';
import '../services/wallpaper_service.dart'; // Import services
import '../services/quote_service.dart';
import '../services/wallpaper_setter_service.dart';
import '../services/schedule_service.dart';

class DashboardScreen extends StatefulWidget {
  final String categoryName;
  // Add service properties
  final WallpaperService wallpaperService;
  final QuoteService quoteService;
  final WallpaperSetterService wallpaperSetterService;
  final ScheduleService scheduleService;

  const DashboardScreen({
    super.key,
    required this.categoryName,
    required this.wallpaperService,
    required this.quoteService,
    required this.wallpaperSetterService,
    required this.scheduleService,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _handleTimeframeChanged(int minutes) {
    print('Timeframe changed to $minutes minutes');
    // TODO: Implement ScheduleService integration - update wallpaper schedule
  }

  void _handleSetWallpaperNow() {
    print('Set Wallpaper Now button pressed');
    // TODO: Implement WallpaperSetterService integration - set wallpaper immediately
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Motiv8Me - ${widget.categoryName}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.categoryName,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TimeframeDropdown(
              onTimeframeChanged: _handleTimeframeChanged,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Set Wallpaper Now',
              onPressed: _handleSetWallpaperNow,
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: WallpaperPreview(
                wallpaperUrl: null,
                quoteText: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}