import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Ensure cached_network_image is in pubspec.yaml

class WallpaperPreview extends StatelessWidget {
  final String? wallpaperUrl;
  final String? quoteText;
  final String? categoryName;

  const WallpaperPreview({
    super.key,
    this.wallpaperUrl,
    this.quoteText,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // Rounded corners for the preview
      child: AspectRatio(
        aspectRatio: 9 / 16, // Portrait aspect ratio (adjust if needed)
        child: Stack(
          fit: StackFit.expand, // Make stack fill the AspectRatio area
          children: [
            // Wallpaper Layer - Conditionally display image or placeholder
            if (wallpaperUrl != null)
              CachedNetworkImage(
                imageUrl: wallpaperUrl!,
                fit: BoxFit.cover, // Cover the area, maintaining aspect ratio
                placeholder: (context, url) => _buildPlaceholder(), // Show placeholder during loading
                errorWidget: (context, url, error) => _buildPlaceholder(), // Show placeholder on error
              )
            else
              _buildPlaceholder(), // Show placeholder if no wallpaper URL

            // Scrim Overlay - Gradient to improve text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2), // Top: slightly transparent
                    Colors.black.withOpacity(0.5), // Bottom: semi-transparent
                  ],
                ),
              ),
            ),

            // Quote Text - Displayed on top of wallpaper with styling
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding around quote text
              child: Center(
                child: Text(
                  quoteText ?? '', // Display quote text or empty string if null
                  style: Theme.of(context).textTheme.titleLarge?.copyWith( // Use theme's titleLarge as base
                        color: Colors.white, // White text color for contrast
                        shadows: [ // Text shadow for better visibility on wallpaper
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                  textAlign: TextAlign.center, // Center align the quote text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the placeholder UI when no wallpaper or during loading/error
  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300], // Light grey placeholder background color
      child: const Center(
        child: Icon(
          Icons.image_outlined, // Image outlined icon as placeholder
          size: 48,
          color: Colors.grey, // Grey color for the icon
        ),
      ),
    );
  }
}

