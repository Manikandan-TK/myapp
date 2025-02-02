// lib/services/wallpaper_setter_service.dart
// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

class WallpaperSetterService {

  // Main method to set wallpaper from URL with permission handling
  Future<bool> setWallpaperFromUrl(String imageUrl) async {
    // Check for storage permission on Android (using Permission.storage)
    PermissionStatus permissionStatus = await _checkWallpaperPermission();

    if (permissionStatus == PermissionStatus.granted) {
      // Proceed with setting the wallpaper if permission is granted
      return _setWallpaperInternal(imageUrl, WallpaperManagerPlus.bothScreens);
    } else if (permissionStatus == PermissionStatus.denied) {
      // Request permission if denied
      permissionStatus = await _requestWallpaperPermission();
      if (permissionStatus == PermissionStatus.granted) {
        return _setWallpaperInternal(imageUrl, WallpaperManagerPlus.bothScreens);
      } else {
        print("Storage permission denied. Cannot set wallpaper."); // Updated message
        return false;
      }
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      // Handle permanently denied permission - guide user to app settings
      print("Storage permission permanently denied. Please enable it in app settings."); // Updated message
      openAppSettings(); // Open app settings for user to manually enable
      return false;
    } else {
      // For other statuses (e.g., restricted), just indicate failure
      print("Storage permission not granted. Status: $permissionStatus"); // Updated message
      return false;
    }
  }

  // Internal method to set wallpaper (assumes permission is already granted)
  Future<bool> _setWallpaperInternal(String imageUrl, int location) async {
    PermissionStatus permissionStatus = await _checkWallpaperPermission(); // Double check inside internal method for safety
    if (!permissionStatus.isGranted) {
      print("Storage permission not granted internally, even after initial check."); // Updated message
      return false; // Exit if permission is not granted even in internal method
    }
    try {
      final cachedImage = await DefaultCacheManager().getSingleFile(imageUrl);
      if (cachedImage == null) {
        print("Error: Cached image file not found for URL: $imageUrl");
        return false; // Indicate failure if cached image is not found
      }
      // Set wallpaper based on the provided location - CORRECTED METHOD NAME (already corrected in previous response)
      await WallpaperManagerPlus().setWallpaper(cachedImage.path, location);
      return true; // Indicate success
    } catch (e) {
      print('Error setting wallpaper: $e'); // Log any errors during wallpaper setting
      return false; // Indicate failure if exception occurs
    }
  }


  // Private method to check storage permission (using Permission.storage)
  Future<PermissionStatus> _checkWallpaperPermission() async {
    if (!Platform.isAndroid) {
      // No need to check permissions on non-Android platforms
      return PermissionStatus.granted;
    }
    return await Permission.storage.status; // Check Permission.storage status
  }

  // Private method to request storage permission (using Permission.storage)
  Future<PermissionStatus> _requestWallpaperPermission() async {
    if (!Platform.isAndroid) {
      // No need to request permissions on non-Android platforms
      return PermissionStatus.granted;
    }
    return await Permission.storage.request(); // Request Permission.storage
  }
}

