import 'package:flutter/material.dart';

class QuoteDisplay extends StatelessWidget {
  final String? quoteText;

  const QuoteDisplay({
    super.key,
    this.quoteText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      quoteText ?? 'Loading quote...', // Display placeholder text if quoteText is null
      style: Theme.of(context).textTheme.titleLarge?.copyWith( // Start with theme's titleLarge style
            color: Colors.white, // White text color for contrast
            fontWeight: FontWeight.bold, // Use FontWeight.bold for stronger emphasis on quote
            shadows: [ // Text shadow for better readability
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
      textAlign: TextAlign.center, // Center align the quote text
    );
  }
}