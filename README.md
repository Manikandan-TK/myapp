# Motiv8Me - Motivational Wallpaper App

## Project Summary

**Motiv8Me** is a Flutter mobile application designed to provide users with daily motivation to overcome bad habits.  The app achieves this by automatically changing device wallpapers (both lock and home screens) to display inspiring images and motivational quotes, tailored to the user's selected category of habit they wish to break.

**Core Functionality:**

*   **Motivational Wallpapers & Quotes:**  Dynamically sets device wallpapers with inspiring images and relevant quotes.
*   **Habit Categories:** Users can select a specific category of habit they are focusing on quitting (e.g., Smoking, Alcohol, Social Media Addiction, etc.). This allows for more targeted and relevant motivational content.
*   **Automatic Wallpaper Changes:**  Users can set a timeframe (hourly, daily, weekly) for automatic wallpaper updates, ensuring consistent motivation throughout the day.
*   **"Set Wallpaper Now" Feature:**  Provides an immediate way for users to refresh their wallpaper and get a new dose of motivation on demand.
*   **Wallpaper Preview:**  Displays a preview of the current or scheduled wallpaper and quote within the app.

**Target Audience:**

Individuals seeking daily motivation and visual reminders to help them quit bad habits and achieve their personal goals.

**Tech Stack:**

*   **Flutter:**  Cross-platform mobile app development framework.
*   **Dart:**  Programming language for Flutter.
*   **Plugins:**
    *   `wallpaper_manager_plus`: For setting device wallpapers (lock & home screen).
    *   `flutter_cache_manager`: For efficient image caching and management.
    *   `permission_handler`: For handling runtime permissions on Android (specifically for setting wallpaper).
    *   `http`: For making HTTP requests to fetch images from Unsplash API.
    *   `shared_preferences`: For persistent storage of user settings (timeframe, last wallpaper change time).

**Development Context:**

This project was developed as a **1-day rapid prototyping challenge**, leveraging the power of Large Language Models (LLMs) such as Qwen and Claude for code generation. The primary goal was to demonstrate the feasibility of building a functional mobile application within a very limited timeframe using AI-assisted development.

**Current Status:**

The app is currently a functional prototype.  It successfully demonstrates:

*   UI structure with Category Selection and Dashboard screens.
*   Reusable widgets for category tiles, timeframe selection, primary buttons, wallpaper preview, and custom app bar.
*   Basic services for wallpaper and quote management (with `WallpaperService` integrated with Unsplash API for fetching real images).
*   Runtime permission handling for setting wallpapers on Android.
*   Service injection and basic app flow.

**Potential Next Steps & Enhancements:**

*   Implement actual quote fetching and integration into `QuoteService`.
*   Connect `ScheduleService` to the UI to enable automatic wallpaper changes based on user-selected timeframe.
*   Implement the "Set Wallpaper Now" functionality.
*   Enhance UI/UX with improved styling, animations, and user feedback.
*   Implement user settings and preferences.
*   Add more categories and customization options.
*   Thorough testing and bug fixing.

**This project serves as a testament to the potential of LLMs in accelerating mobile app development and enabling rapid prototyping.**

---
**Note:**  This `readme.md` is a starting point and can be further expanded with more detailed information, setup instructions, contribution guidelines, etc., as the project evolves.
