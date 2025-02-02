import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget { // Implement PreferredSizeWidget for correct AppBar sizing
  final String titleText;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.titleText,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.titleLarge?.copyWith( // Use theme's titleLarge as base style
              color: Theme.of(context).colorScheme.onPrimary, // Text color from theme for contrast
              fontWeight: FontWeight.bold, // Bold font weight for title
            ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary, // Background color from theme (primary color)
      foregroundColor: Theme.of(context).colorScheme.onPrimary, // Icon and action color from theme
      elevation: 0, // No shadow for a flatter app bar
      centerTitle: true, // Center the title text (optional stylistic choice)
      leading: leading, // Optional leading widget (e.g., back button)
      actions: actions, // Optional list of action widgets (e.g., menu icons)
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Define preferred size for AppBar
}