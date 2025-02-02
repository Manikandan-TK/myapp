// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../widgets/category_tile.dart';
import '../widgets/custom_app_bar.dart';
import './dashboard_screen.dart'; // Placeholder import for DashboardScreen
import '../services/wallpaper_service.dart'; // Import services
import '../services/quote_service.dart';
import '../services/wallpaper_setter_service.dart';
import '../services/schedule_service.dart';

// Define categories with names and icons as a constant list
const List<Map<String, dynamic>> categories = [
  {'name': 'Smoking', 'icon': Icons.smoking_rooms},
  {'name': 'Alcohol', 'icon': Icons.local_drink},
  {'name': 'Drug Use', 'icon': Icons.medical_services_outlined},
  {'name': 'Social Media', 'icon': Icons.thumb_up_off_alt},
  {'name': 'Eating Disorders', 'icon': Icons.restaurant_outlined},
  {'name': 'Gaming', 'icon': Icons.videogame_asset},
];

class CategorySelectionScreen extends StatelessWidget {
  // Add service properties
  final WallpaperService wallpaperService;
  final QuoteService quoteService;
  final WallpaperSetterService wallpaperSetterService;
  final ScheduleService scheduleService;

  // Modify constructor to accept services
  const CategorySelectionScreen({
    super.key,
    required this.wallpaperService,
    required this.quoteService,
    required this.wallpaperSetterService,
    required this.scheduleService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Choose Your Focus',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: categories.map((category) {
            return CategoryTile(
              categoryName: category['name'] as String,
              iconData: category['icon'] as IconData,
              onTap: () {
                // Print category name to console on tap
                print('Category "${category['name']}" selected');
                // Navigate to DashboardScreen with selected category, passing services
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(
                      categoryName: category['name'] as String,
                      wallpaperService: wallpaperService, // Pass services here
                      quoteService: quoteService,
                      wallpaperSetterService: wallpaperSetterService,
                      scheduleService: scheduleService,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
