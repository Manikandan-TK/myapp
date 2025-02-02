// lib/services/wallpaper_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallpaper.dart'; // Import Wallpaper model

class WallpaperService {
  final String unsplashApiKey = 'dsPDxTKzPceqMOlGJFGsMqAZ9aYEmz4PvM1vvUGRjLk'; // Replace with your API key

  Future<Wallpaper?> getRandomWallpaper() async {
    final String apiUrl = 'https://api.unsplash.com/photos/random?orientation=portrait&query=motivational&client_id=$unsplashApiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        final String imageUrl = jsonData['urls']['regular']; // Or 'full', 'raw', 'small', 'thumb' - choose size
        final String category = 'Motivational'; // You can customize category if needed
        return Wallpaper(imageUrl: imageUrl, category: category);
      } else {
        print('Failed to fetch wallpaper from Unsplash API. Status code: ${response.statusCode}');
        print('Response body: ${response.body}'); // Log response body for debugging
        return null;
      }
    } catch (e) {
      print('Error fetching wallpaper: $e');
      return null;
    }
  }
}